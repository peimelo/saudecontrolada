class RenameColumnPesoToValorInPesos < ActiveRecord::Migration[5.1]
  def change
    rename_column :pesos, :peso, :valor
  end
end
