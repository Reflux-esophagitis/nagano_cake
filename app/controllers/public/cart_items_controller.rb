class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total_price = CartItem.total_price(@cart_items)
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    cart_item.item_id = cart_item_params[:item_id]
    # カート内に存在するなら
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      # 数量を加算
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    else
      cart_item.save
      redirect_to cart_items_path
    end
  end

  def update
    @cart_items = current_customer.cart_items
    @cart_item = current_customer.cart_items.find_by(
      item_id: params[:cart_item][:item_id]
    )

    selected_amount = params[:cart_item][:amount]
    @cart_item.update(amount: selected_amount)

    # redirect_to cart_items_path
    render :cart_table
  end

  def destroy
    @cart_items = current_customer.cart_items
    @cart_item = current_customer.cart_items.find_by(item_id: params[:id])
    if @cart_item
      # item_name = cart_item.item.name
      @cart_item.destroy
      # redirect_to cart_items_path, notice: "#{item_name}を削除しました。"
      render :cart_table
    else
      # カート内アイテムが見つからなかったときの処理
      # redirect_to cart_items_path, alert: "選択した商品が見つかりませんでした。"
      render :cart_table
    end
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    current_customer.cart_items.destroy_all
    # redirect_to cart_items_path, notice: "カートを空にしました。"
    render :cart_table
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
