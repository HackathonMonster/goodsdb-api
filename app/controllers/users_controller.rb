class UsersController < ApplicationController
  before_action :find_user

  def login
    @user = User.facebook_authenticate(params[:facebook_id], params[:facebook_token])
    if @user
      @include_authorization = true
      render :show
    else
      render json: { error: 'wrong id or access token' }, status: :unauthorized
    end
  end

  private

  def find_user
    @user = User.find(params[:id]) if params[:id]
  end
end
