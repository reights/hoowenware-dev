class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :response
      t.references :user, index: true
      t.references :trip, index: true

      t.timestamps
    end
  end
end
