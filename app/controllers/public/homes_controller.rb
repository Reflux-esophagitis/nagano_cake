class Public::HomesController < ApplicationController
  def top
    # TODO
    # 全商品ではなく、新着商品を取得する
    @items = Item.all
    @genres = Genre.all
  end

  def about
  end
end
