class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :mirror_id
      t.integer :order_id
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :total_price_item

      t.timestamps
    end
  end
end
