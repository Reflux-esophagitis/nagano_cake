class Admin::OrderDetailsController < ApplicationController

  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(status: params[:order_detail][:status])
    redirect_to admin_order_path(order_detail.order)
  end

end
