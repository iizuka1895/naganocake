class Item < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_one_attached :image
  has_many :orders
  
  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  def add_tax_price
    self.price ||= 0
    (self.price * 1.1).round
  end
  
end
