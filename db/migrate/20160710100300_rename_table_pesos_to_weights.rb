class RenameTablePesosToWeights < ActiveRecord::Migration[5.0]
  def change
    rename_table :pesos , :weights
  end
end
