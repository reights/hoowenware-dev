class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name,       :null => false, :default => "", :unique => true
      t.text :description
      t.text :group_type
      t.text :location
      t.text :avatar
      t.text :facebook_url
      t.text :meetup_url
      t.text :groupme_id
      t.boolean :is_active, :default => true

      t.timestamps
    end
  end
end
