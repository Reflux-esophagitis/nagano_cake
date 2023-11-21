module Admin::SearchesHelper

  def search_form_action
    if admin_signed_in?
      admin_search_path
    else
      customer_search_path
    end
  end

end
