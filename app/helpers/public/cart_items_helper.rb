module Public::CartItemsHelper
  # 商品の数量を選択できる範囲を返すメソッドです。
  # この範囲は、最小選択可能量（MIN_SELECTABLE_AMOUNT）から、
  # 指定された最大量（max_amount）または最大選択可能量（MAX_SELECTABLE_AMOUNT）の大きい方までの範囲です。
  # デフォルトでは、最大選択可能量までの範囲が使用されます。
  #
  # @param max_amount [Integer] 範囲の上限を指定するオプションのパラメータ。
  # @return [Range] 最小選択可能量から指定された最大量まで、または最大選択可能量までの範囲。
  def amount_range(max_amount = MAX_SELECTABLE_AMOUNT)
    MIN_SELECTABLE_AMOUNT..[max_amount, MAX_SELECTABLE_AMOUNT].max
  end
end
