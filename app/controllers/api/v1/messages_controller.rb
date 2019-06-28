class Api::V1::MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    chat = Chat.find(params[:chat_id])
    message.user = current_user
    message.chat = chat

    if message.save
      MessagesChannel.broadcast_to chat, MessageSerialzer.new(message)
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
