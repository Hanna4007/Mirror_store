class AddOrderItemHeightToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :order_item_height, :integer
  end
end
