class Order < ApplicationRecord

  enum payment_method: { credit_card: 0, transfer: 1 },
       status: {
         awaiting_payment: 0,
         payment_confirmed: 1,
         in_production: 2,
         preparing_for_shipment: 3,
         shipped: 4
       }

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  # 商品詳細と商品データを事前に読み込む
  scope :with_details_and_items, -> { includes(order_details: :item) }

  # 顧客データと商品詳細、商品合計数を事前読み込み
  scope :with_details_amount_and_customer, -> {
    joins(:order_details)
    .select('orders.*, SUM(order_details.amount) as total_amount')
    .group('orders.id')
    .includes(:customer)
  }

  # 日時が新しいものが先にくるようにする
  scope :recent, -> { order(created_at: :desc) }

  validates :name, presence: true
  validates :zip_code, presence: true
  validates :address, presence: true
  validates :payment_method, presence: true, inclusion: { in: payment_methods.keys }
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :total_price, presence: true
  validates :postage, presence: true

  def full_address
    "#{self.zip_code} #{self.address}"
  end

  def complete_all_details?
    order_details.all? { |detail| detail.status_before_type_cast == 3 }
  end

  def total_amount
    order_details.sum(:amount)
  end
end
