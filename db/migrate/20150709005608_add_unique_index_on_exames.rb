class AddUniqueIndexOnExames < ActiveRecord::Migration
  def change
    add_index :exames, [:nome, :parent_id, :unidade_id], unique: true
  end
end
