class Api::V1::MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    chat = Chat.find(params[:chat_id])
    message.user = current_user
    message.chat = chat

    if message.save
      serialized_message = ActiveModelSerializers::SerializableResource.new(message, {serializer: MessageSerializer}).as_json
      MessagesChannel.broadcast_to chat, serialized_message
      head :ok
    else
      render json: {error: 'Unable to send message'}
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
