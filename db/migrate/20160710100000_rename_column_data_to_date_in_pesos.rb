class RenameColumnDataToDateInPesos < ActiveRecord::Migration[5.1]
  def change
    rename_column :pesos , :data, :date
  end
end
