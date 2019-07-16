class Api::V1::ChatsController < ApplicationController
  def index
    render json: current_user.chats, include: ['messages', 'messages.user']
  end

  def create
    chat = Chat.create(chat_params)
    if chat.valid?
      render json: chat, include: ['messages', 'messages.user']
    else
      render json: {error: chat.errors.full_messages}
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:title, user_ids: [])
  end
end
