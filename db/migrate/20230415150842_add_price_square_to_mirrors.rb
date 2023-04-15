class AddPriceSquareToMirrors < ActiveRecord::Migration[7.0]
  def change
    add_column :mirrors, :price_square, :integer
  end
end
