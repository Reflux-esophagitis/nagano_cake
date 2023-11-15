module Public::OrdersHelper

# num導入後に不要ならば削除
  def payment_method
    if self.payment_method == 0
      "クレジットカード"
    elsif self.payment_method == 1
      "銀行振込"
    end
  end

  def full_address
    "#{self.zip_code} #{self.address}"
  end

end
