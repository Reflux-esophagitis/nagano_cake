module Public::ItemsHelper
  def item_alt_text(item)
    "#{item.name}の説明：#{item.introduction}"
  end

  def counts_text(count)
    "（全#{count}件）"
  end
end
