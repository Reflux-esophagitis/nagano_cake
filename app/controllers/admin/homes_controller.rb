class Admin::HomesController < ApplicationController
  def top
    @orders = current_customer.orders
  end
end
