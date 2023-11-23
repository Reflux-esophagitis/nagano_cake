class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @category = params[:category]
    search_items
    @show_items = @search_items.page(params[:page])
    @search_items_count = @search_items.count
  end

  private
    def search_items
      #検索フォームに入力がない場合、元のページにリダイレクト
      redirect_to request.referer, alert: "検索フォームに文字を入力してください" if @word.empty?

      if @category == "item"
        # 商品名検索
        @search_items = Item.looks_name(@word)
      elsif @category == "genre"
        # 商品ジャンル検索
        @search_items = Item.looks_genre(@word)
      end
    end

end
