class CreateWebLinks < ActiveRecord::Migration
  def change
    create_table :web_links do |t|
      t.integer :user_id
      t.string :url
      t.references :user, index: true

      t.timestamps
    end
  end
end
