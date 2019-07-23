class Api::V1::AuthController < ApplicationController
  skip_before_action :authorised, only: :create

  def create
    user = User.find_by(username: auth_params[:username])
    if user && user.authenticate(auth_params[:password])
      token = encode_token(user_id: user.id)
      byebug
      render json: {user: user, jwt: token}
    else
      render json: {message: 'Invalid username or password'}
    end
  end

  private

  def auth_params
    params.require(:user).permit(:username, :password)
  end
end
