class AddProfileDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :zip_code, :string
    add_column :users, :mobile_number, :string
    add_column :users, :dietary_restrictions, :string
    add_column :users, :roommate_preferences, :string
  end
end
