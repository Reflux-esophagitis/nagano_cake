class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @registered_addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new
    @order_items = current_customer.cart_items
    @order.total_price = CartItem.total_price(@order_items)
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method].to_i
    @order.postage = POSTAGE
    set_address
  end

  def create
    @order = Order.new(order_params)
    @order.save
    byebug
    create_details(@order)
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_details
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

    def address_params
      params.require(:order).permit(:zip_code, :address, :name)
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

    # オーダー登録画面にて選択された住所から条件分岐
    # 0:ユーザーの登録情報を配送先として使用
    # 1:ユーザーが以前登録した配送先を使用
    # 2:新規住所を登録して配送先として使用
    def set_address
      case params[:order][:address_method].to_i
      when 0
        set_address_from_customer
      when 1
        set_address_from_registered
      when 2
        set_address_from_params
      end
    end

    def set_address_from_customer
      assign_address(current_customer.zip_code, current_customer.address, current_customer.full_name)
    end

    def set_address_from_registered
      registered_address = current_customer.addresses.find(params[:order][:address_id])
      assign_address(registered_address.zip_code, registered_address.address, registered_address.name)
    end

    def set_address_from_params
      if params[:order][:zip_code].blank? || params[:order][:address].blank? || params[:order][:name].blank?
        redirect_to new_order_path
      else
        assign_address(params[:order][:zip_code], params[:order][:address], params[:order][:name])
        current_customer.addresses.create(address_params)
      end
    end

    def assign_address(zip_code, address, name)
      @order.zip_code = zip_code
      @order.address = address
      @order.name = name
    end

end
