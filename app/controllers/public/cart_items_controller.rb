class Public::CartItemsController < ApplicationController
  before_action :set_cart_items, only: %i[index update destroy destroy_all]

  def index
    @cart_items = current_customer.cart_items.with_items_and_images
    @total_price = CartItem.total_price(@cart_items)
  end

  def create
    item_id = cart_item_params[:item_id]
    new_amount = cart_item_params[:amount].to_i

    @cart_item = CartItem.find_or_initialize_by(
      customer_id: current_customer.id,
      item_id: item_id
    )

    item_name = @cart_item.item.name

    # カート内に既に存在するなら
    if @cart_item.new_record?
      @cart_item.amount = new_amount
    else
      @cart_item.amount += new_amount
    end

    if @cart_item.save
      redirect_to cart_items_path, notice: "#{item_name}をカートに追加しました。"
    else
      @item = Item.find(item_id)
      @genres = Genre.all
      render "public/items/show"
    end
  end

  def update
    @cart_item = @cart_items.find_by(
      item_id: cart_item_params[:item_id]
    )

    selected_amount = cart_item_params[:amount]
    item_name = @cart_item.item.name

    @cart_item.update(amount: selected_amount)

    flash.now[:notice] = "#{item_name}の数量を#{selected_amount}個に変更しました。"
    render :cart_table
  end

  def destroy
    @cart_item = @cart_items.find_by(item_id: params[:id])

    if @cart_item
      @item_name = @cart_item.item.name
      @cart_item.destroy

      flash.now[:notice] = "#{@item_name}をカートから削除しました。"
      render :cart_table
    else

      flash.now[:alert] = "選択した商品が見つかりませんでした。"
      render :cart_table
    end
  end

  def destroy_all
    @cart_items.destroy_all

    flash.now[:notice] = "カートを空にしました。"
    render :cart_table
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def set_cart_items
    @cart_items = current_customer.cart_items
  end
end
