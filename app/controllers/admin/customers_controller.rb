class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: %i[show edit update orders]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end

  def orders
    @orders = @customer.orders
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "#{@customer.full_name}さんの情報を更新しました"
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(
      :first_name,
      :last_name,
      :first_name_kana,
      :last_name_kana,
      :zip_code,
      :address,
      :telephone_number,
      :email,
      :is_active
    )
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
