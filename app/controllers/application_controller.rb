class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_user, :user_signed_in?

  if Rails.env != 'development'
    rescue_from GoodsDbApi::AuthenticationError, with: :return_401
  end

  def current_user
    @user ||= User.find_by(token: request.headers['X-Token'])
  end

  def user_signed_in?
    !current_user.nil?
  end

  def authenticate_user!
    fail GoodsDbApi::AuthenticationError, 'not logged in' unless user_signed_in?
  end

  def return_401
    render json: { error: 'not authorized' }, status: :unauthorized
  end
end
