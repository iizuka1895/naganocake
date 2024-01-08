class Public::ItemsController < ApplicationController
  def index
    @all_items = Item.all
    @items = Item.page(params[:page])
    @item = Item.new
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  private
  
  def items_params
    params.require(item).permit(:name, :introduction, :price, :is_active, :image)
  end
end