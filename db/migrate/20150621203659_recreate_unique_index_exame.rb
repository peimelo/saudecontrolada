class RecreateUniqueIndexExame < ActiveRecord::Migration[5.1]
  def change
    remove_index :exames, :nome
    add_index :exames, [:nome, :ancestry], unique: true
  end
end
