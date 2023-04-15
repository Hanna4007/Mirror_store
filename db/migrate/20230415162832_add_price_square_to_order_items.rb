class AddPriceSquareToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :price_square, :decimal
  end
end
