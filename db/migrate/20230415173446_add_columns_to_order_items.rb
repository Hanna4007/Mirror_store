# frozen_string_literal: true

class AddColumnsToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :glass_thickness, :integer
    add_column :order_items, :light, :string
    add_column :order_items, :heater, :boolean
  end
end
