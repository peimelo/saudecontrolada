class RenameColumnReferenciaIdToReferenceIdInValores < ActiveRecord::Migration[5.0]
  def change
    rename_column :valores , :referencia_id, :reference_id
  end
end
