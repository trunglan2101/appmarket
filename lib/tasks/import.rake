require 'csv'
namespace :import do
  desc "TODO"
  task categories: :environment do
    import_file = Rails.root + "public/categories.csv"
    count = 0
    CSV.foreach(import_file, headers: true) do |row|
      cate = Category.create(name: row["name"], description: row["description"])
      count += 1 if cate.persisted?
    end
    puts "import #{count} category new"
  end
end
