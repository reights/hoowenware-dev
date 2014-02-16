class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email,      :null => false, :default => ""
      t.string :full_name
      t.string :avatar
      t.references :user,   :index => true
      t.references :trip,   :index => true

      t.timestamps
    end
  end
end
