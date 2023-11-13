class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      redirect_to new_admin_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update
      redirect_to admin_item_path(@item)
    else
      redirect_to edit_admin_item_path(@item)
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :non_taxed_price, :introduction, :is_active, :image)
  end
end
