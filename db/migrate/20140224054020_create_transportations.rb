class CreateTransportations < ActiveRecord::Migration
  def change
    create_table :transportations do |t|
      t.string :transportation_type
      t.string :service_number
      t.string :seat_number
      t.float :price
      t.boolean :deposit_required
      t.text :notes
      t.string :departure_city
      t.date :departure_date
      t.time :departure_time
      t.string :arrival_city
      t.date :arrival_date
      t.time :arrival_time
      t.references :trip, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
