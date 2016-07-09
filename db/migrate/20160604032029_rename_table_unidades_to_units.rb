class RenameTableUnidadesToUnits < ActiveRecord::Migration[5.0]
  def change
    rename_table :unidades, :units
  end
end
