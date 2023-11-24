class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  # カートアイテムデータ内の商品情報とその画像を事前に読み込む
  scope :with_items_and_images, -> { includes(item: { image_attachment: :blob }) }

  # 商品の小計を計算します。
  # 商品の税抜価格に数量を掛け、その後消費税を加算して最終的な小計を求めます。
  # このメソッドでは、小数点以下の丸め処理は行っていません。

  # @return [Numeric] 計算された商品の小計（税込み価格）
  def subtotal
    price = item.non_taxed_price

    (price * amount) * (1 + TAX_RATE)
  end

  # カート内の各アイテムについて、subtotalメソッドを呼び出して各アイテムの小計を求め、
  # それらの小計を合計してカート内の総額を計算します。
  #
  # `map`メソッドは各アイテムのsubtotalを配列として収集し、
  # `sum`メソッドはその配列の要素（各小計）を合計します。
  #
  # `&:subtotal`はRubyのシンタックスシュガーで、以下のコードと同じです。
  # `cart_items.map { |item| item.subtotal }.sum`
  def self.total_price(cart_items)
    cart_items.map(&:subtotal).sum
  end
end
