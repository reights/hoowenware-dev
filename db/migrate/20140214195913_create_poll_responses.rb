class CreatePollResponses < ActiveRecord::Migration
  def change
    create_table :poll_responses do |t|
      t.hstore :choices
      t.references :user, index: true
      t.references :trip, index: true

      t.timestamps
    end
  end
end
