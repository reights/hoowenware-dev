class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, :null => false, :default => "", :unique => true
      t.string :is_active, default: true

      t.timestamps
    end
  end
end
