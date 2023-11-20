class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :price, presence: true
  validates :amount, presence: true
  validates :status, presence: true, inclusion: { in: [*0..3] }
end
