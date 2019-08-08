class Api::V1::MessagesController < ApplicationController
  before_action :find_chat

  def index
    render json: chat.messages
  end

  def create
    message = Message.new(message_params)
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

  def find_chat
    chat = Chat.find(params[:chat_id])
  end
end
