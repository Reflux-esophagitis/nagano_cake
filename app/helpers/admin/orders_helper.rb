module Admin::OrdersHelper

  def default_selected(order)
    order.complete_all_details? ? 4 : ""
  end
end
