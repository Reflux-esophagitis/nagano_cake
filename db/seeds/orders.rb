module Seeds
  class Orders
    MAX_RANDOM_ORDERS = 20
    MAX_CART_ITEMS = 5
    MAX_ITEM_AMOUNT = 10
    ORDER_STATUS_RANGE = 0..4
    PAYMENT_METHOD_RANGE = 0..1
    
    def self.create()
      customers = Customer.all
      items_count = Item.count

      customers.each do |customer|
        rand(1..MAX_RANDOM_ORDERS).times do
          cart_items = (1..MAX_CART_ITEMS).map do
            cart_item = CartItem.create(
              customer_id: customer.id,
              item_id: rand(1..items_count),
              amount: rand(1..MAX_ITEM_AMOUNT)
            )

            cart_item
          end

          order = Order.create(
            customer_id: customer.id,
            name: customer.full_name,
            zip_code: customer.zip_code,
            address: customer.address,
            total_price: CartItem.total_price(cart_items),
            postage: POSTAGE,
            status: rand(ORDER_STATUS_RANGE),
            payment_method: rand(PAYMENT_METHOD_RANGE)
          )

          cart_items.each do |cart_item|
            order.order_details.create!({
              item_id: cart_item.item_id,
              amount: cart_item.amount,
              price: cart_item.subtotal
            })
          end

          CartItem.destroy_all

          puts "[Seeds] Created order #{order.id} for customer #{customer.id}"
        end
      end
    end
  end
end
