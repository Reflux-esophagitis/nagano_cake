module ApplicationHelper
  ##
  # ヘッダーナビの各項目を返します。
  # 顧客もしくは管理者のログイン状態によって項目が変わります。
  #
  # @return [Array<Hash>] ヘッダーナビ項目の配列
  #   @option (Hash) :path [String] リンク先のURL。
  #   @option (Hash) :text [String] リンクの表示テキスト。
  #   @option (Hash) :method (optional) [Symbol] HTTPメソッド（例：:delete）。指定無しの場合は空にします。
  def nav_items
    if admin_signed_in?
      admin_nav_items
    elsif customer_signed_in?
      customer_nav_items
    else
      guest_nav_items
    end
  end

  # 与えられた数値を日本円形式でフォーマットします。
  # 小数点以下は丸められ、整数で表示されます。
  # 通貨記号の表示/非表示を選択できます。
  #
  # @param number [Numeric] フォーマットする数値
  # @param include_currency_symbol [Boolean] 円記号（￥）を表示する場合はtrue、非表示の場合はfalse
  # @return [String] フォーマットされた通貨文字列
  #
  # 使用例：
  #   to_jpy_format(1500.75, true) #=> "￥1,501"
  #   to_jpy_format(1500.75, false) #=> "1,501"
  def to_jpy_format(number, include_currency_symbol)
    currency_symbol = include_currency_symbol ? "￥" : ""

    number_to_currency(
      number,
      unit: currency_symbol,
      precision: 0
    )
  end

  private
  def admin_nav_items
    [
      {
        path: admin_items_path,
        text: "商品一覧"
      },
      {
        path: admin_customers_path,
        text: "会員一覧"
      },
      {
        path: admin_root_path,
        text: "注文履歴一覧"
      },
      {
        path: admin_genres_path,
        text: "ジャンル一覧"
      },
      {
        path: destroy_admin_session_path,
        text: "ログアウト",
        method: :delete
      }
    ]
  end

  def customer_nav_items
    [
      {
        path: mypage_customers_path,
        text: "マイページ"
      },
      {
        path: items_path,
        text: "商品一覧"
      },
      {
        path: cart_items_path,
        text: "カート"
      },
      {
        path: destroy_customer_session_path,
        text: "ログアウト",
        method: :delete
      }
    ]
  end

  def guest_nav_items
    [
      {
        path: about_path,
        text: "About"
      },
      {
        path: items_path,
        text: "商品一覧"
      },
      {
        path: new_customer_registration_path,
        text: "新規登録"
      },
      {
        path: new_customer_session_path,
        text: "ログイン"
      }
    ]
  end
end
