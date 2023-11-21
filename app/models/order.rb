class Order < ApplicationRecord

  enum payment_method: { credit_card: 0, transfer: 1},
       status: {
         awaiting_payment: 0,
         payment_confirmed: 1,
         in_production: 2,
         preparing_for_shipment: 3,
         shipped: 4
       }

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true
  validates :payment_method, presence: true, inclusion: {in: Order.payment_methods.keys}
  validates :status, presence: true, inclusion: {in: Order.statuses.keys }
  validates :total_price, presence: true
  validates :postage, presence: true

  def full_address
    "#{self.zip_code} #{self.address}"
  end

  def complete_all_details?
    order_details.all? { |detail| detail.status == 3 }
  end
end
