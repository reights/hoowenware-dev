class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :title
      t.string :hash_tag
      t.date :start_date
      t.date :end_date
      t.string :location
      t.boolean :is_private, default: false
      t.boolean :hide_guestlist, default: false
      t.boolean :is_active, default: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
