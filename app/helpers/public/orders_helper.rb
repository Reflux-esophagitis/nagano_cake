module Public::OrdersHelper

# num導入後に不要ならば削除
  def payment_method(args)
    if args.payment_method == 0
      "クレジットカード"
    elsif args.payment_method == 1
      "銀行振込"
    end
  end

  def full_address(args)
    "#{args.zip_code} #{args.address}"
  end

end
