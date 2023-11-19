class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @statuses = {
       "入金待ち" => 0,
       "入金確認" => 1,
       "制作中" => 2,
       "発送準備中" => 3,
       "発送済み" => 4
    }

    @detail_statuses = {
       "製作不可" => 0,
       "制作待ち" => 1,
       "制作中" => 2,
       "制作完了" => 3
    }
  end

  def update
    order = Order.find(params[:id])
    new_status = params[:order][:status].to_i
    if new_status == 4
      if order.complete_all_details?
        order.update(status: params[:order][:status])
      else
        # メッセージは未実装
        flash[:notice] = "すべての商品を制作完了にしてください。"
      end
    else
      order.update(status: params[:order][:status])
      flash[:notice] = "注文ステータスを更新しました。"
    end
    redirect_to admin_order_path(order)
  end


end
