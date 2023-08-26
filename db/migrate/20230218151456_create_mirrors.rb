# frozen_string_literal: true

class CreateMirrors < ActiveRecord::Migration[7.0]
  def change
    create_table :mirrors do |t|
      t.string :name
      t.integer :height
      t.integer :width
      t.integer :glass_thickness
      t.string :light
      t.boolean :heater, null: false, default: false
      t.integer :price

      t.timestamps
    end
  end
end
