class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_user, :user_signed_in?

  def current_user
    @user ||= User.find_by(token: request.headers['X-Token'])
  end

  def user_signed_in?
    !current_user.nil?
  end

  def authenticate_user!
    fail GoodsDbApi::AuthenticationError, 'not logged in' unless user_signed_in?
  end
end
