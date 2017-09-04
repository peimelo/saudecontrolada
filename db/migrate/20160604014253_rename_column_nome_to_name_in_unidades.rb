class RenameColumnNomeToNameInUnidades < ActiveRecord::Migration[5.1]
  def change
    rename_column :unidades, :nome, :name
  end
end
