class RemoveAncestryDepthFromExames < ActiveRecord::Migration
  def change
    remove_column :exames, :ancestry_depth
  end
end
