module Public::OrdersHelper

  def order_items_name(order)
    order.order_details.map { |detail| detail.item.name }.join("\n")
  end

  def full_address(order)
    "〒#{order.zip_code} #{order.address}"
  end

end
