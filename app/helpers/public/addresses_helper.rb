module Public::AddressesHelper

  def address_btn
    current_page?(addresses_path) ? "新規登録" : "変更内容を保存"
  end

end
