class Public::AddressesController < ApplicationController
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
    if @address.update(order_params)
      redirect_to index
    else
      render :edit
    end
  end

  private
    def address_params
      params.require(:address).permit(:zip_code, :address, :name)
    end
end
