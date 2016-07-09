class RenameTableReferenciasToReferences < ActiveRecord::Migration[5.0]
  def change
    rename_table :referencias, :references
  end
end
