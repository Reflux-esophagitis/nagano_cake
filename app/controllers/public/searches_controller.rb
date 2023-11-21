class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @category = params[:category]
    search_items
  end

  private
    def search_items
      case @category
      when "item"
      # 商品名検索
      @search_items = Item.where("name LIKE?", "%#{@word}%")
      when "genre"
      # 商品ジャンル検索
      @search_items = Item.includes(:genre).where(genres: { name: @word }).references(:genre)
      end
    end
end
