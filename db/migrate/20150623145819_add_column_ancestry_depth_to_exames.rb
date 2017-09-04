class AddColumnAncestryDepthToExames < ActiveRecord::Migration[5.1]
  def change
    add_column :exames, :ancestry_depth, :integer, default: 0
  end
end
