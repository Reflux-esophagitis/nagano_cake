class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def subtotal
    price = item.non_taxed_price

    ((price * amount) * (1 + TAX_RATE)).truncate
  end
end
