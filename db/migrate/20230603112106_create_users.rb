# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :name
      t.string :password_digest
      t.boolean :admin, default: false
      t.string :phone_number, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
