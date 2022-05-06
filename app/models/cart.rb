class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many :cart_items
  accepts_nested_attributes_for :cart_items, reject_if: :reject_cart_items

  validates :total_price, numericality: { greater_than: 1000 }

  def reject_cart_items(attributes)
    attributes["product_id"].blank?
  end
end
