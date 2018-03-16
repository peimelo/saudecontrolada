class RemoveAncestryDepthFromExames < ActiveRecord::Migration[5.1]
  def change
    remove_column :exames, :ancestry_depth
  end
end
