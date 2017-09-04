class RenameColumnValorToValueInPesos < ActiveRecord::Migration[5.1]
  def change
    rename_column :pesos , :valor, :value
  end
end
