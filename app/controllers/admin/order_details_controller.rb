class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    new_status = params[:order_detail][:status].to_i
    order = order_detail.order
    # 注文ステータスが発送済の場合にアラート
    if order.status == "shipped"
      flash[:alert] = "製作ステータスが発送済みのため、注文ステータスを変更できません。"
    # 製作ステータスが製作中の場合
    elsif new_status == 2
      flash[:notice] = "製作ステータスを更新しました。"
      order_detail.update(status: params[:order_detail][:status].to_i)
      # 一つでもあれば注文ステータスを製作中に変更
      if order.order_details.any? { |order_detail| order_detail.status == "in_production" }
        order.update(status: 2)
      end
    elsif new_status == 3
      flash[:notice] = "製作ステータスを更新しました。"
      order_detail.update(status: params[:order_detail][:status].to_i)
      # 全てであれば注文ステータスを発送準備中に変更
      if order.order_details.all? { |order_detail| order_detail.status == "production_completed" }
        order.update(status: 3)
      end
    else
      # それ以外の場合
      flash[:notice] = "製作ステータスを更新しました。"
      order_detail.update(status: params[:order_detail][:status].to_i)
    end
    redirect_to admin_order_path(order_detail.order)
  end
end
