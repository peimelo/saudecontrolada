class AddAncestryToExame < ActiveRecord::Migration
  def change
    add_column :exames, :ancestry, :string
    add_index :exames, :ancestry
  end
end
