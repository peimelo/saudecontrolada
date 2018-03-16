class RenameColumnSexoToGenderInValores < ActiveRecord::Migration[5.1]
  def change
    rename_column :valores , :sexo, :gender
  end
end
