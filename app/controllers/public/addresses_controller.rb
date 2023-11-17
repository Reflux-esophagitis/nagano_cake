class Public::AddressesController < ApplicationController
  before_action :is_matching_address_customer, only: %i[edit update destroy]

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to index
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
     @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id]).destroy
    redirect_to addresses_path
  end

  private
    def address_params
      params.require(:address).permit(:zip_code, :address, :name)
    end

    def is_matching_address_customer
      customer = Address.find(params[:id]).customer
      if customer != current_customer
        redirect_to addresses_path
      end
    end
end
