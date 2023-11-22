class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :email, presence: true

  def full_name
    self.last_name + self.first_name
  end

  def active_for_authentication?
    super && (is_active == true)
  end

  def self.looks_name(word)
    Customer.where(
        "first_name LIKE ? OR last_name LIKE ?", "%#{word}%", "%#{word}%"
    )
  end

end
