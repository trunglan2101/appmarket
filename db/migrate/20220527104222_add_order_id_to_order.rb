class AddOrderIdToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_id, :integer
  end
end
