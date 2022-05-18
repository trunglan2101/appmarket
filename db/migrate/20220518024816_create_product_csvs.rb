class CreateProductCsvs < ActiveRecord::Migration[6.1]
  def change
    create_table :product_csvs do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :category_id

      t.timestamps
    end
  end
end
