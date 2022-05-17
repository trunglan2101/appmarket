class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.text :note
      t.integer :total_price
      t.integer :user_id

      t.timestamps
    end
  end
end
