class AddInstallationAndLampToMirrors < ActiveRecord::Migration[7.0]
  def change
    add_column :mirrors, :installation, :string
    add_column :mirrors, :lamp, :string
  end
end
