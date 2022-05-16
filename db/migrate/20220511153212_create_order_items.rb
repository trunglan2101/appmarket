class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.string :image
      t.string :product_name
      t.integer :product_price
      t.integer :quantity
      t.integer :total
      t.integer :order_id

      t.timestamps
    end
  end
end
