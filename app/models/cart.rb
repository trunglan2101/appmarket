class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  accepts_nested_attributes_for :cart_items, reject_if: :reject_cart_items

  def reject_cart_items(attributes)
    attributes["product_id"].blank?
  end
end
