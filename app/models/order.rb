class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  validates :name, :address, :phone, presence: true
  accepts_nested_attributes_for :order_items
end
