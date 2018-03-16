class RenameTableUnidadesToUnits < ActiveRecord::Migration[5.1]
  def change
    rename_table :unidades, :units
  end
end
