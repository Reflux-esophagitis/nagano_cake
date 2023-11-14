class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @registered_addresses = current_customer.addresses
  end

  def confirm
    @order_items = current_customer.cart_items
  end

  def complete
  end

  def index
  end

  def show
  end

  private
    def order_params
      params.require(:order).permit(:name, :zip_code, :address, :payment_method)
    end
end
