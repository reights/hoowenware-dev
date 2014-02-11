class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :group_id
      t.string :email
      t.string :role
      t.integer :last_updated_by
      t.boolean :is_active, default: false
      t.boolean :is_admin, default: false
      t.references :group, index: true

      t.timestamps
    end
  end
end
