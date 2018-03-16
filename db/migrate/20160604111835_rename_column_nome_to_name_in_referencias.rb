class RenameColumnNomeToNameInReferencias < ActiveRecord::Migration[5.1]
  def change
    rename_column :referencias, :nome, :name
  end
end
