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
