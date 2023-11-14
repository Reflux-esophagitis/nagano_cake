class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @registered_addresses = current_customer.addresses
  end

  def confirm
    @order_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    case params[:address_method]
    when 0
      @order.zip_code = current_customer.zip_code
      @order.address = current_customer.address
      @order.name = current_customer.name
    when 1
      registered_address = customer.addresses.find_by(params[address_id])
      @order.zip_code = registered_address.zip_code
      @order.address = registered_address.address
      @order.name = registered_address.name
    when 2
      if params[:zip_code].blank? || params[:address].blank? || params[:name].blank?
        flash[:error] = "配送先が入力されていません"
        redirect_to new_order_path
      else
        new_address = current_customer.address.create({
          zip_code: params[:zip_code],
          address: params[:address],
          name: params[:name]
        })
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
      params.require(:order).permit(:name, :zip_code, :address, :payment_method)
    end
end
