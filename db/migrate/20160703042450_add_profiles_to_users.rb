class AddProfilesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :introduce, :string
    add_column :users, :homepage, :string
  end
end
