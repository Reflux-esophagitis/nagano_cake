class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @items_count = Item.count
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :non_taxed_price, :introduction, :is_active, :image)
  end
end
