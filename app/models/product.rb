class Product < ApplicationRecord
  has_one_attached :image
  paginates_per 4

  belongs_to :category
  has_many :cart_items

  validates :name, uniqueness: true
end
