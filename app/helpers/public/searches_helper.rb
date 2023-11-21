module Public::SearchesHelper
  def category_text(word, category)
    categories = {
      "item" => "#{word}の検索結果",
      "genre" => "#{word}一覧"
    }
    categories[category]
  end
end
