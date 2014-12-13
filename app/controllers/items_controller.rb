class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item

  def create
    @item = current_user.items.build(item_params)
  end

  private

  def item_params
    params.require(:items).permit(:name, :pictures, :tags)
  end

  def find_item
    @item = Item.find(params[:id]) if params[:id]
  end
end
