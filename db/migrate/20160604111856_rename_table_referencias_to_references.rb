class RenameTableReferenciasToReferences < ActiveRecord::Migration[5.1]
  def change
    rename_table :referencias, :references
  end
end
