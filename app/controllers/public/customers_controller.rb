class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def confirm
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_customers_path, notice: '会員情報を更新しました。'
    else
      render :edit
    end
  end

  def leave
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path, notice: '退会処理を実行しました。'
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :zip_code, :address, :telephone_number, :email)
  end
end
