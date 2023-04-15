class AddWidthToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :width, :integer
  end
end
