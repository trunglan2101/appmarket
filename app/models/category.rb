class Category < ApplicationRecord
  validates :name, uniqueness: true
  has_many :products

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Category.create(name: row["name"], description: row["description"])
    end
  end
end
