class AddColumnAncestryDepthToExames < ActiveRecord::Migration
  def change
    add_column :exames, :ancestry_depth, :integer, default: 0
  end
end
