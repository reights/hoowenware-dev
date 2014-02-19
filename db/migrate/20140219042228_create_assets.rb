class CreateAssets < ActiveRecord::Migration
  create_table :assets do |t|
    t.string :asset
    t.references :trip

    t.timestamps
  end

  remove_column :trips, :asset
end