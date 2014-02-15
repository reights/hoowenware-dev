class CreateEntityMeta < ActiveRecord::Migration
  def change
    create_table :entity_meta do |t|
      t.integer :entity_id,  :null => false
      t.string :entity_type, :null => false, :default => ""
      t.string :meta_type,   :null => false, :default => ""
      t.string :data,        :null => false, :default => ""

      t.timestamps
    end
  end
end
