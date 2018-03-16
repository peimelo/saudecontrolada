class RenameColumnValidToValidoInValores < ActiveRecord::Migration[5.1]
  def change
    rename_column :valores , :valid, :valido
  end
end
