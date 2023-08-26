# frozen_string_literal: true

class CreateInformation < ActiveRecord::Migration[7.0]
  def change
    create_table :information, &:timestamps
  end
end
