class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @statuses = Order.statuses.map do |key, value|
      [I18n.t("enums.order.status.#{key}"), value]
    end
    @detail_statuses = OrderDetail.statuses.map do |key, value|
      [I18n.t("enums.order_detail.status.#{key}"), value]
    end
  end

  def update
    order = Order.find(params[:id])
    new_status = params[:order][:status].to_i
    if new_status == 4
      if order.complete_all_details?
        order.update(status: new_status)
        flash[:notice] = "注文ステータスを更新しました。"
      else
        flash[:alert] = "すべての商品を制作完了にしてください。"
      end
    else
      order.update(status: new_status)
      flash[:notice] = "注文ステータスを更新しました。"
    end
    redirect_to admin_order_path(order)
  end


end
