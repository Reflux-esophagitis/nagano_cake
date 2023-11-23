class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin!, if: :admin_area?


  private
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :admin
      new_admin_session_path
    when :customer
      root_path
    end
  end

  # リダイレクト先をログイン画面からルートパスに変更
  def authenticate_admin!
    unless current_admin
      redirect_to root_path
    end
  end

  # sign_inページ以外のadminが含まれるurlにリクエストする場合 TRUE
  def admin_area?
    request.fullpath.include?("/admin") && !request.fullpath.include?("/admin/sign_in")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :zip_code, :address, :telephone_number, :is_active ])
  end

end
