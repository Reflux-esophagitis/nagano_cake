class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_one_attached :image

  scope :active, -> { where(is_active: true) }

  def taxed_price
    # 税込単価の計算
    # 端数は切り捨てとした
    (non_taxed_price * (1 + TAX_RATE)).truncate
  end
end
