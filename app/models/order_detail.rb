class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  validates :item_id, presence: true
  
  def subtotal
    item.add_tax_price * quantity
  end
end
