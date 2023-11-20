class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :price, presence: true
  validates :amount, presence: true
  validates :status, presence: true, inclusion: { in: [*0..3] }

  enum status: {
    not_producible: 0,
    awaiting_production: 1,
    in_production: 2,
    production_completed: 3
  }
  
end
