class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :non_taxed_price, presence: true
  validates :is_active, presence: true

  scope :active, -> { where(is_active: true) }

  # 税込単価の計算
  def taxed_price
    non_taxed_price * (1 + TAX_RATE)
  end

  def self.looks_name(word)
    Item.where("name LIKE?", "%#{word}%")
  end

  def self.looks_genre(word)
    Item.includes(:genre).where(genres: { name: word }).references(:genre)
  end
end
