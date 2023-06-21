class RenameTypeToDeliveryTypeInDeliveries < ActiveRecord::Migration[7.0]
  def change
    rename_column :deliveries, :type, :delivery_type
  end
end
