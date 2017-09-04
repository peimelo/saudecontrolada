class RenameColumnValidoToValidInValores < ActiveRecord::Migration[5.1]
  def change
    rename_column :valores , :valido, :valid
  end
end
