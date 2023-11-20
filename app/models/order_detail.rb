class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum status: {
    not_producible: 0,
    awaiting_production: 1,
    in_production: 2,
    production_completed: 3
  }
end
