class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :non_taxed_price, presence: true
  validates :is_active, inclusion: [true, false]

  # 販売中の商品
  scope :active, -> { where(is_active: true) }

  # ジャンルデータを事前読み込み
  scope :with_genre, -> { includes(:genre) }

  # 追加日時降順
  scope :recent, -> { order(created_at: :desc) }

  # 主に顧客側で使用
  # 日時降順で販売中の商品を画像も一括で読み込む
  scope :recent_active_items_with_images, -> { recent.active.with_attached_image }

  # 主に管理者側で使用
  # 日時降順でジャンルデータを事前に読み込む
  scope :recent_with_genre, -> { recent.with_genre }

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
