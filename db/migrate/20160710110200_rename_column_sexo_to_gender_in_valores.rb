class RenameColumnSexoToGenderInValores < ActiveRecord::Migration[5.0]
  def change
    rename_column :valores , :sexo, :gender
  end
end
