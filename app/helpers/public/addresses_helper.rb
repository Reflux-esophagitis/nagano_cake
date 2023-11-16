module Public::AddressesHelper

  def address_btn_text
    current_page?(addresses_path) ? "新規登録" : "変更内容を保存"
  end

end
