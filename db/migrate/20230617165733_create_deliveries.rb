# frozen_string_literal: true

class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string :type
      t.string :post
      t.string :receiver_name
      t.string :receiver_surname
      t.string :receiver_phone_number
      t.string :city
      t.string :receiver_address
      t.integer :post_office_number
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
