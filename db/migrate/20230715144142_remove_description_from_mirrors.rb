class RemoveDescriptionFromMirrors < ActiveRecord::Migration[7.0]
  def change
    remove_column :mirrors, :description
  end
end
