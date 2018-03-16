class AddUniqueIndexOnExames < ActiveRecord::Migration[5.1]
  def change
    add_index :exames, [:nome, :parent_id, :unidade_id], unique: true
  end
end
