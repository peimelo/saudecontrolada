class RenameColumnDataToDateInPesos < ActiveRecord::Migration[5.0]
  def change
    rename_column :pesos , :data, :date
  end
end
