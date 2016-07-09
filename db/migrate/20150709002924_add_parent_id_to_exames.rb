class AddParentIdToExames < ActiveRecord::Migration
  def change
    add_column :exames, :parent_id, :integer, null: true
    add_foreign_key :exames, :exames, column: :parent_id
  end
end
