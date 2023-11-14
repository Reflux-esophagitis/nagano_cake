class Public::CartItemsController < ApplicationController
  def index
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    cart_item.item_id = cart_item_params[:item_id]
    # カート内に存在するなら
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      # 数量を加算
      cart_item.amount += params[:crat_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    else
      cart_item.save
      redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
