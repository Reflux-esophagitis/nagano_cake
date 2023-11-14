class Item < ApplicationRecord
  belongs_to :genre

  has_one_attached :image

  scope :active, -> { where(is_active: true) }
end
