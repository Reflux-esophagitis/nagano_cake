class Admin::SearchesController < ApplicationController
  before_action :admin_check

  def search
    @word = params[:word]
    if params[:category] == "genre"
      # ジャンル検索の場合は顧客側と同様のparams[:category]を使用
      @category = params[:category]
      @search_results = Item.looks_genre(@word)
    else
      # フォームからの検索はセレクトボックスからのparams[:admin_category]を使用
      # hidden_fieldにてparams[:category]に"item"を渡しているため
      @category = params[:admin_category]
      serch_selected_category
    end
  end

  private
    def admin_check
      redirect_to root_path unless admin_signed_in?
    end

    def serch_selected_category
      if @category == "item" && !@word.empty?
        # 商品名検索
        @search_results = Item.looks_name(@word)
      elsif @category == "customer" && !@word.empty?
        # 顧客名検索
        @search_results = Customer.looks_name(@word)
      else
        redirect_to request.referer, alert: "検索フォームに文字を入力してください"
      end
    end

end
