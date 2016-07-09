class RemoveColumnTelefonesInContatos < ActiveRecord::Migration[5.0]
  def change
    remove_column :contatos, :telefones
  end
end
