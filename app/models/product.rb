class Product < ApplicationRecord
  has_one_attached :image
  paginates_per 4

  belongs_to :category
  belongs_to :order
  has_many :cart_items
end
