class RemovePriceFromMirrors < ActiveRecord::Migration[7.0]
  def change
    remove_column :mirrors, :price, :integer
  end
end
