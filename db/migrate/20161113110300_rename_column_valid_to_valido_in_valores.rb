class RenameColumnValidToValidoInValores < ActiveRecord::Migration[5.0]
  def change
    rename_column :valores , :valid, :valido
  end
end
