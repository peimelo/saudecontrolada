class RemoveAncestryFromExames < ActiveRecord::Migration[5.1]
  def change
    remove_column :exames, :ancestry
  end
end
