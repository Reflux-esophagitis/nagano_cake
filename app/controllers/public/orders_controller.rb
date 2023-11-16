class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @registered_addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new
    order_items = current_customer.cart_items
    @order.total_price = CartItem.total_price(order_items)
    @order.customer_id = current_customer.id
    @order.postage = POSTAGE
    case params[:order][:address_method].to_i
    when 0
      @order.zip_code = current_customer.zip_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    when 1
      registered_address = customer.addresses.find(params[:address_id])
      @order.zip_code = registered_address.zip_code
      @order.address = registered_address.address
      @order.name = registered_address.name
    when 2
      if params[:order][:zip_code].blank? || params[:order][:address].blank? || params[:order][:name].blank?
        # flash[:error] = "配送先が入力されていません"
        redirect_to new_order_path
      else
        current_customer.address.create({
          zip_code: params[:order][:zip_code],
          address: params[:order][:address],
          name: params[:order][:name]
        })
      end
    end
  end

  def create
    @order = Order.new(order_params)
    @order.save
    create_details(@order)
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
  end

  def show
  end

  private

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

    # カートアイテムを注文詳細に変換
    # その後ログインユーザーのカートアイテムを全削除
    # トランザクションにて問題発生時にカートアイテムを消さない
    def create_details(order)
      ActiveRecord::Base.transaction do
        cart_items = current_customer.cart_items
        cart_items.each do |cart_item|
          order.order_details.create!({
            item_id: cart_item.item_id,
            amount: cart_item.amount,
            price: cart_item.subtotal
          })
        end
        cart_items.destroy_all
      end
    end

end
