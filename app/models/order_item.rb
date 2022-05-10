class OrderItem < ApplicationRecord
  belongs_to :order
  validates :name, :address, :phone, :product_name, :product_price, :quantity, :total, presence: true
end
