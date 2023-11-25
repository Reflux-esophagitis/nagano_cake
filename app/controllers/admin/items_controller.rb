class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: %i[show edit update]

  def index
    @items = Item.page(params[:page]).recent_with_genre
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      name = @item.name
      redirect_to admin_item_path(@item), notice: "新しい商品「#{name}」を追加しました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      name = @item.name
      redirect_to admin_item_path(@item), notice: "#{name}の情報を更新しました。"
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :introduction,
      :genre_id,
      :non_taxed_price,
      :is_active
    )
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
