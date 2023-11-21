class Admin::SearchesController < ApplicationController
  def search
    @word = params[:word]
    search_items
    search_customer
  end

  private
    def search_items
      # 商品名検索
      @search_name_items = Item.where("name LIKE?", "%#{@word}%")
      # 商品ジャンル検索
      @search_genre_items = Item.includes(:genre).where(genres: { name: @word }).references(:genre)
    end

    def search_customer
      # 顧客名検索
      @search_name_customers = Customer.where(
        "first_name LIKE ? OR last_name LIKE ?", "%#{@word}%", "%#{@word}%"
        )
    end

end
