class AddRegionToDeliveries < ActiveRecord::Migration[7.0]
  def change
    add_column :deliveries, :region, :string
  end
end
