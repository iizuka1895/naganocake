class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :customer_id, presence: true
  validates :name, presence: true
  validates :adress, presence: true
  validates :post_code, presence: true
  validates :postage, presence: true
  validates :payment, presence: true
  validates :method_of_payment, presence: true

  enum method_of_payment: { credit_card: 0, transfer: 1 }


end
