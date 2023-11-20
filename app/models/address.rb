class Address < ApplicationRecord
  belongs_to :customer

  validates :name, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true

  def full_address
    "〒#{self.zip_code} #{self.address}"
  end
end
