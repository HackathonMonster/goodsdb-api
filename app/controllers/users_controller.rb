class UsersController < ApplicationController
  before_action :find_user

  def login
    @user = User.facebook_authenticate(params[:facebook_id], params[:facebook_token])
    user_or_error
  end

  def current
    @user = current_user
    user_or_error
  end

  private

  def user_or_error
    if @user
      @include_authorization = true
      render :show
    else
      render json: { error: 'wrong id or access token' }, status: :unauthorized
    end
  end

  def find_user
    @user = User.find(params[:id]) if params[:id]
  end
end
