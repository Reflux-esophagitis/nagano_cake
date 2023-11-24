class CartItem < ApplicationRecord
  include ItemAmountCalculations

  belongs_to :customer
  belongs_to :item

  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  # カートアイテムデータ内の商品情報とその画像を事前に読み込む
  scope :with_items_and_images, -> { includes(item: { image_attachment: :blob }) }
end
