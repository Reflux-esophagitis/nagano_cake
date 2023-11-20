class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true
  validates :payment_method, presence: true, inclusion: { in: [0, 1], message: "は0, 1のいずれかでなければなりません" }
  validates :status, presence: true, inclusion: { in: [0, 1, 2, 3, 4], message: "は0, 1, 2, 3, 4のいずれかでなければなりません" }
  validates :total_price, presence: true
  validates :postage, presence: true

  def full_address
    "#{self.zip_code} #{self.address}"
  end

  def complete_all_details?
    order_details.all? { |detail| detail.status == 3 }
  end
end
