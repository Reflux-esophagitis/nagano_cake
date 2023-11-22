class Public::OrdersController < ApplicationController
  before_action :check_cart_empty, only: %i[new confirm create complete]

  def new
    @order = Order.new
    @registered_addresses = current_customer.addresses
  end

  def confirm
    @order_items = current_customer.cart_items
    @order = current_customer.orders.new({
      total_price: CartItem.total_price(@order_items),
      payment_method: params[:order][:payment_method].to_i,
      postage: POSTAGE
    })
    set_address
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

    # ログインユーザーの登録情報を使用
    def set_address_from_customer
      assign_address(current_customer.zip_code, current_customer.address, current_customer.full_name)
    end

    # ユーザーが以前登録した配送先を使用
    def set_address_from_registered
      registered_address = current_customer.addresses.find(params[:order][:address_id])
      assign_address(registered_address.zip_code, registered_address.address, registered_address.name)
    end

    # 新規住所を登録して配送先として使用
    def set_address_from_params
      if address_params.values.any?(&:blank?)
        redirect_to new_order_path, alert: "配送先が入力されていません"
      else
        assign_address(*address_params.values)
        current_customer.addresses.create(address_params)
      end
    end

    # 登録用メソッド
    def assign_address(zip_code, address, name)
      @order.zip_code = zip_code
      @order.address = address
      @order.name = name
    end

    def check_cart_empty
      if current_customer.cart_items.empty?
        redirect_to items_path, alert: "カートに商品がありません"
      end
    end

end
