class AddAvatarToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :avatar, :string
    add_column :users, :name, :string, default:"no update"
    add_column :users, :admin, :boolean, default: false
  end
end
