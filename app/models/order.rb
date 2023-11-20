class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy


  validates :name, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true
  validates :payment_method, presence: true, inclusion: { in: [0, 1] }
  validates :status, presence: true, inclusion: { in: [*0..4] }
  validates :total_price, presence: true
  validates :postage, presence: true
  
  enum payment_method: { credit_card: 0, transfer: 1},
     status: {
       awaiting_payment: 0,
       payment_confirmed: 1,
       in_production: 2,
       preparing_for_shipment: 3,
       shipped: 4
     }


  def full_address
    "#{self.zip_code} #{self.address}"
  end

  def complete_all_details?
    order_details.all? { |detail| detail.status == 3 }
  end
end
