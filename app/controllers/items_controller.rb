class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:show, :add_event, :update]
  before_action :check_user, only: [:update]

  def index
    @items = current_user.items.includes(:tags, :pictures)
  end

  def create
    @item = current_user.items.build_from_attributes(item_param)
    render_or_error
  end

  def update
    @item.assign_params(item_param)
    render_or_error
  end

  def add_event
    case params[:event]
    when 'lost' then @event = @item.trigger_lost
    when 'found' then @event = @item.trigger_found
    else return json error: 'incorrect event', status: :bad_request
    end
    render json: @event, status: :created
  end

  def search
    base_relation = params[:all_users] ? Item : current_user.items
    search_type = params[:type] || 'found'
    tags = params.require(:tags).is_a?(Array) ? params[:tags] : []
    @items = base_relation.with_pictures.search(tags, search_type)
    render :index
  end

  private

  def render_or_error
    if @item.save
      render :show
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
