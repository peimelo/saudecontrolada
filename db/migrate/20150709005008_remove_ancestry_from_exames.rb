class RemoveAncestryFromExames < ActiveRecord::Migration
  def change
    remove_column :exames, :ancestry
  end
end
