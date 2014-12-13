class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item

  def index
    @items = current_user.items
  end

  def create
    @item = current_user.items.build_from_attributes(item_params)
    if @item.save
      render :show
    else
      render json: @item.errors
    end
  end

  private

  def item_params
    params.require(:item)
  end

  def find_item
    @item = Item.find(params[:id]) if params[:id]
  end
end
