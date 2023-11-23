class CartItem < ApplicationRecord
  include ItemAmountCalculations
  
  belongs_to :customer
  belongs_to :item

  validates :amount, numericality: { only_integer: true, greater_than: 0 }
end
