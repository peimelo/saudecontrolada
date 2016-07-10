class RenameColumnValidoToValidInValores < ActiveRecord::Migration[5.0]
  def change
    rename_column :valores , :valido, :valid
  end
end
