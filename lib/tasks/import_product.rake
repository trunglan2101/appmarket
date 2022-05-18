require "csv"
namespace :import_product do
  desc "TODO"
  task products: :environment do
    product_file = Rails.root + "public/products.csv"
    count = 0  
    CSV.foreach(product_file, headers: true) do |row|
      product = Product.create(name: row["Name"], 
                              description: row["Description"], 
                              price: row.to_h["Price"], 
                              category_id: row.to_h["Category_id"])
      count += 1 if product.persisted?
    end
    puts "import #{count} product new"
  end
end
