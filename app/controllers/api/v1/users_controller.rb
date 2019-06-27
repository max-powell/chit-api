class Api::V1::UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: @user
    else
      render json: {error: @user.errors.full_messages}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
