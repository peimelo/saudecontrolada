class AddUniqueIndexInResultados < ActiveRecord::Migration
  def change
    add_index :resultados, [:data, :descricao, :user_id], unique: true
  end
end
