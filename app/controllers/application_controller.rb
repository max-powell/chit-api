class ApplicationController < ActionController::API
  before_action :authorised

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.dig(:jwt_secret))
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]

      begin
        JWT.decode(token, Rails.application.credentials.dig(:jwt_secret))
      rescue
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorised
    render json: {message: 'Please log in'} unless logged_in?
  end
end
