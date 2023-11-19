class Address < ApplicationRecord
  belongs_to :customer

  def full_address
    "〒#{self.zip_code} #{self.address}"
  end

end
