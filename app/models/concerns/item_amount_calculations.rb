module ItemAmountCalculations
  extend ActiveSupport::Concern

  # 商品の小計を計算します。
  # 商品の税抜価格に数量を掛け、その後消費税を加算して最終的な小計を求めます。
  # このメソッドでは、小数点以下の丸め処理は行っていません。
  #
  # @return [Numeric] 計算された商品の小計（税込み価格）
  def subtotal
    price = item.non_taxed_price
    (price * amount) * (1 + TAX_RATE)
  end

  class_methods do
    # 各アイテムのsubtotalメソッドを呼び出して小計を求め、
    # それらの小計を合計して総額を計算します。
    #
    # `map`メソッドは各アイテムのsubtotalを配列として収集し、
    # `sum`メソッドはその配列の要素（各小計）を合計します。
    #
    # `&:subtotal`はRubyのシンタックスシュガーで、以下のコードと同じです。
    # `items.map { |item| item.subtotal }.sum`
    def total_price(items)
      items.map(&:subtotal).sum
    end
  end
end