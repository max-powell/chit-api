class Api::V1::UsersController < ApplicationController
  skip_before_action :authorised, only: :create

  def profile
    render json: current_user
  end

  def index
    users = User.all.reject { |u|
      u == current_user
    }.sort_by{ |u| u[:username].downcase}
    render json: users, each_serializer: SenderSerializer
  end

  def create
    user = User.create(user_params)
    byebug
    if user.valid?
      token = encode_token(user_id: user.id)
      render json: {user: user, jwt: token}
    else
      render json: {error: user.errors.full_messages}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
