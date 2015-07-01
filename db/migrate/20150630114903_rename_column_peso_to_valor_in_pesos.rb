class RenameColumnPesoToValorInPesos < ActiveRecord::Migration
  def change
    rename_column :pesos, :peso, :valor
  end
end
