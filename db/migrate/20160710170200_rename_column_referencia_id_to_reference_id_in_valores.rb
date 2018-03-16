class RenameColumnReferenciaIdToReferenceIdInValores < ActiveRecord::Migration[5.1]
  def change
    rename_column :valores , :referencia_id, :reference_id
  end
end
