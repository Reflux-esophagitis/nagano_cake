class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page]).with_details_amount_and_customer.recent
  end
end
