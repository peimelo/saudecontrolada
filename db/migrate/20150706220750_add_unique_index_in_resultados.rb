class AddUniqueIndexInResultados < ActiveRecord::Migration[5.1]
  def change
    add_index :resultados, [:data, :descricao, :user_id], unique: true
  end
end
