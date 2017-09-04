class AddAncestryToExame < ActiveRecord::Migration[5.1]
  def change
    add_column :exames, :ancestry, :string
    add_index :exames, :ancestry
  end
end
