class Category < ApplicationRecord
  validates :name, uniqueness: true
  has_many :products

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # Category.create!(name: row.to_hash["name"], description: row.to_hash["description"])
      parameters = ApplicationController::Parameters.new(row.to_hash)
      Category.create!(parameters.permit(:name, :description))
    end
  end
end
