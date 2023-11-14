class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :non_taxed_price, presence: true
  validates :is_active, presence: true

  scope :active, -> { where(is_active: true) }
end
