class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @registered_addresses = current_customer.addresses
  end

  def confirm
    @order_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    case address_method
    when 0
      @order.zip_code = current_customer.zip_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    when 1
      registered_address = customer.addresses.find_by(params[address_id])
    when 2
      if params[:zip_code].blank? || params[:address].blank? || params[:name].blank?
        flash[:error] = "配送先が入力されていません"
        redirect_to new_order_path
      else
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      end
    end
  end

  def complete
  end

  def index
  end

  def show
  end

  private
    def order_params
      params.require(:order).permit(:name, :zip_code, :address, :payment_method, :address_method)
    end
end
