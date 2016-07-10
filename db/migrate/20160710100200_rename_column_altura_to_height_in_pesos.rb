class RenameColumnAlturaToHeightInPesos < ActiveRecord::Migration[5.0]
  def change
    rename_column :pesos , :altura, :height
  end
end
