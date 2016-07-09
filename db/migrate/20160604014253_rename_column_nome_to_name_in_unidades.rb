class RenameColumnNomeToNameInUnidades < ActiveRecord::Migration[5.0]
  def change
    rename_column :unidades, :nome, :name
  end
end
