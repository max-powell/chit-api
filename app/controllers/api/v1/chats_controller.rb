class Api::V1::ChatsController < ApplicationController
  def index
    render json: current_user.chats
  end
end
