class RenameColumnDataToDateInResultados < ActiveRecord::Migration[5.0]
  def change
    rename_column :resultados, :data, :date
  end
end
