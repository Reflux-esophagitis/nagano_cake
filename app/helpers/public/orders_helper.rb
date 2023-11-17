module Public::OrdersHelper

# num導入後に不要ならば削除
  def payment_method_text(order)
    order.payment_method == 0 ? "クレジットカード" : "銀行振込"
  end

end
