class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @registered_addresses = current_customer.addresses
  end

  def confirm
  end

  def complete
  end

  def index
  end

  def show
  end
end
