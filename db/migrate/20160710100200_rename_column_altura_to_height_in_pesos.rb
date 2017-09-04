class RenameColumnAlturaToHeightInPesos < ActiveRecord::Migration[5.1]
  def change
    rename_column :pesos , :altura, :height
  end
end
