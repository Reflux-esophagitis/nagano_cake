class Public::OrdersController < ApplicationController
  # 定数の保管場所は相談
  POSTAGE = 800
  TAX_FEE = 1.08

  def new
    @order = Order.new
    @registered_addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new
    order_items = current_customer.cart_items
    @order.total_price = total_price(order_items)
    @order.customer_id = current_customer.id
    @order.postage = POSTAGE
    case params[:address_method]
    when 0
      @order.zip_code = current_customer.zip_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    when 1
      registered_address = customer.addresses.find_by(params[address_id])
      @order.zip_code = registered_address.zip_code
      @order.address = registered_address.address
      @order.name = registered_address.name
    when 2
      if params[:zip_code].blank? || params[:address].blank? || params[:name].blank?
        # flash[:error] = "配送先が入力されていません"
        redirect_to new_order_path
      else
        current_customer.address.create({
          zip_code: params[:zip_code],
          address: params[:address],
          name: params[:name]
        })
      end
    end
    byebug
  end

  def create
    @new_order = Order.new(order_params)
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
  end

  def show
  end

  private

    def total_price(cart_items)
      total_price = 0
      cart_items.each do |cart_item|
        price, amount = (cart_item.item[:price]*TAX_FEE).to_i, cart_item.item[:amount]
        total_price += price * amount
      end
    end

    def order_params
      params.require(:order).permit(
        :customer_id,
        :name,
        :zip_code,
        :address,
        :payment_method,
        :total_price,
        :postage)
    end
end
