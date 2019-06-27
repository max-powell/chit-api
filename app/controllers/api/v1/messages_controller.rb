class Api::V1::MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.chat_id = params[:chat_id]
    message.user = current_user
    if message.save
      render json: message
    else
      render json: {error: 'Unable to send message'}
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
