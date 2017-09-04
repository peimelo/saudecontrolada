class RenameTablePesosToWeights < ActiveRecord::Migration[5.1]
  def change
    rename_table :pesos , :weights
  end
end
