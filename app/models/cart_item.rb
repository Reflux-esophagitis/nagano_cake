class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  def subtotal
    price = item.non_taxed_price

    (price * amount) * (1 + TAX_RATE)
  end

  def self.total_price(cart_items)
    cart_items.map(&:subtotal).sum
  end
end
