class AddProfileDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender,             :string
    add_column :users, :status,             :string
    add_column :users, :zip_code,           :string
    add_column :users, :mobile_number,      :string
    add_column :users, :skype_id,           :string
    add_column :users, :dietary_pref,       :string
    add_column :users, :roommate_pref,      :string
    add_column :users, :profile_updated,    :boolean, :default => false
  end
end
