class Admin::HomesController < ApplicationController
  def top
    @orders = Order.with_details_amount_and_customer
  end
end
