class AddAssetToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :asset, :string
  end
end
