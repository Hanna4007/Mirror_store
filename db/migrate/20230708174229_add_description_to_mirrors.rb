class AddDescriptionToMirrors < ActiveRecord::Migration[7.0]
  def change
    add_column :mirrors, :description, :text
  end
end
