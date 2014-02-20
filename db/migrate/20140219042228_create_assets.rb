class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :asset
      t.string :content_type
      t.references :trip

      t.timestamps
    end
  end
end