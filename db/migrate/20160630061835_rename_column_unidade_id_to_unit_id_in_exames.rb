class RenameColumnUnidadeIdToUnitIdInExames < ActiveRecord::Migration[5.0]
  def change
    rename_column :exames, :unidade_id, :unit_id
  end
end
