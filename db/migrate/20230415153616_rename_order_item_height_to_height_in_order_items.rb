class RenameOrderItemHeightToHeightInOrderItems < ActiveRecord::Migration[7.0]
  def change
    rename_column :order_items, :order_item_height, :height
  end
end
