module Public::SearchesHelper
  def category_text(category)
    categories = {
      "item" => "商品名：",
      "genre" => "ジャンル名："
    }
    categories[category]
  end
end
