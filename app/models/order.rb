class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  def full_address
    "#{self.zip_code} #{self.address}"
  end
  
end
