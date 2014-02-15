class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :title,            :null => false, :default => ""
      t.string :hash_tag
      t.date :start_date,         :null => false
      t.date :end_date,           :null => false
      t.string :location,         :null => false, :default => ""
      t.boolean :is_private,      :default => false
      t.boolean :hide_guestlist,  :default => false
      t.boolean :is_active,       :default => true
      t.references :user,         :index => true

      t.timestamps
    end
  end
end
