class RenameColumnDataToDateInResultados < ActiveRecord::Migration[5.1]
  def change
    rename_column :resultados, :data, :date
  end
end
