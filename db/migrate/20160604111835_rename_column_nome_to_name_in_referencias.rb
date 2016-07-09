class RenameColumnNomeToNameInReferencias < ActiveRecord::Migration[5.0]
  def change
    rename_column :referencias, :nome, :name
  end
end
