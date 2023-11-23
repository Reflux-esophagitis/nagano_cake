class OrderDetail < ApplicationRecord

  enum status: {
    not_producible: 0,
    awaiting_production: 1,
    in_production: 2,
    production_completed: 3
  }

  belongs_to :item
  belongs_to :order

  # 商品データと画像を事前に読み込む
  # (cart_item)と重複しているが一旦、別々に作成
  scope :with_items_and_images, -> { includes(item: { image_attachment: :blob }) }

  validates :price, presence: true
  validates :amount, presence: true
  validates :status, presence: true, inclusion: {in: OrderDetail.statuses.keys}

end
