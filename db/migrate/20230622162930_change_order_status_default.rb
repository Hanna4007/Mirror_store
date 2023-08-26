# frozen_string_literal: true

class ChangeOrderStatusDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :orders, :status, from: 'not paid', to: 'in progress'
  end
end
