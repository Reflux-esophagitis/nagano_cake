module Admin::SearchesHelper
  def category_text_admin(category)
    categories = {
      "item" => "商品名：",
      "genre" => "ジャンル名：",
      "customer" => "顧客名："
    }
    categories[category]
  end

  def check_search_category(category)
    category == "item" || category == "genre"
  end

  def search_form_action
    if admin_signed_in?
      admin_search_path
    else
      customer_search_path
    end
  end

  def search_target
    {
      "商品名" => "item",
      "顧客名" => "customer"
    }
  end
end
