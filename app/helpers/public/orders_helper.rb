module Public::OrdersHelper

# num導入後に不要ならば削除
  def payment_method_text(order)
    order.payment_method == 0 ? "クレジットカード" : "銀行振込"
  end
# num導入後に不要ならば削除
  def order_status_text(order)
    statuses = {
      0 => "入金待ち",
      1 => "入金確認",
      2 => "制作中",
      3 => "発送準備中",
      4 => "発送済み"
    }
    statuses[order.status]
  end

def order_items_name(order)
  order.order_details.map { |detail| detail.item.name }.join("\n")
end

end
