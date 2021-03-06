class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, except: [:index, :create, :search]
  before_action :check_user, only: [:update, :destroy]

  def index
    @items = current_user.items.includes(:tags, :pictures)
    current_user.add_status(@items)
  end

  def create
    @item = current_user.items.build_from_attributes(item_param)
    render_or_error(:created)
  end

  def search
    base_relation = params[:all_users] ? Item.all : current_user.items
    search_type = params[:type] || 'any'
    tags = params[:tags].is_a?(Array) ? params[:tags] : []
    @items = base_relation.with_pictures
    @items = @items.liked_by(current_user) if params[:favorite]
    @items = @items.filter_status(search_type).filter_tags(tags)
    current_user.add_status(@items)
    render :index
  end

  def update
    @item.assign_params(item_param)
    render_or_error
  end

  def like
    current_user.likes @item
    render json: { success: true }
  end

  def unlike
    current_user.unlike @item
    render json: { success: true }
  end

  def add_event
    case params[:event]
    when 'lost' then @event = @item.trigger_lost
    when 'found' then @event = @item.trigger_found
    else return json error: 'incorrect event', status: :bad_request
    end
    render json: @event, status: :created
  end

  def destroy
    @item.destroy
    render json: { success: true }
  end

  private

  def render_or_error(status = :ok)
    if @item.save
      @item.liked = current_user.liked?(@item)
      render :show, status: status
    else
      render json: @item.errors
    end
  end

  def item_param
    params.require(:item)
  end

  def check_user
    fail GoodsDbApi::AuthorizationError, 'not authorized' if current_user.id != @item.owner_id
  end

  def find_item
    @item = Item.find(params[:id]) if params[:id]
  end
end
