class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :set_headers

  helper_method :current_user, :user_signed_in?

  if Rails.env != 'development'
    rescue_from GoodsDbApi::AuthenticationError, with: :return_401
  end

  def cors_preflight_check
    head :no_content
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

  private

  def set_headers
    origin_regex = Regexp.new(Settings.cors.origin_regex, Regexp::IGNORECASE)
    return unless request.headers['HTTP_ORIGIN'] && origin_regex.match(request.headers['HTTP_ORIGIN'])
    headers['Access-Control-Allow-Origin'] = request.headers['HTTP_ORIGIN']
    Settings.cors.headers.each { |k, v| headers[k.to_s] = v }
  end
end
