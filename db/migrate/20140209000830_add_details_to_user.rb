class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name,  :string
    add_column :users, :avatar,     :string
    add_column :users, :is_admin,   :boolean,   :default => false
  end
end
