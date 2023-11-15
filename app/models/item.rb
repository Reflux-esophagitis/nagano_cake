class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_one_attached :image

  scope :active, -> { where(is_active: true) }

  # 税込単価の計算
  def taxed_price
    non_taxed_price * (1 + TAX_RATE)
  end
end
