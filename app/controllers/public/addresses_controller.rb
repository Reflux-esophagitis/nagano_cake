class Public::AddressesController < ApplicationController
  before_action :is_matching_address_customer, only: %i[edit update destroy]
  before_action :set_address, only: %i[edit update destroy]

  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    # 下記コードは保存失敗時に `ActionControler::UrlGenerationError` が発生します。
    # @address = current_customer.addresses.new(address_params)
    
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id

    if @address.save
      redirect_to addresses_path, notice: "新しい配送先を登録しました。"
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先の内容を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @address.destroy
      redirect_to addresses_path, notice: "配送先を削除しました。"
    else
      render :index
    end
  end

  private
    def address_params
      params.require(:address).permit(:zip_code, :address, :name)
    end

    def set_address
      @address = Address.find(params[:id])
    end

    def is_matching_address_customer
      customer = Address.find(params[:id]).customer
      if customer != current_customer
        redirect_to addresses_path
      end
    end
end
