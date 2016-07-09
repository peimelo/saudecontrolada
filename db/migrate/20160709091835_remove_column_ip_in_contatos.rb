class RemoveColumnIpInContatos < ActiveRecord::Migration[5.0]
  def change
    remove_column :contatos, :ip
  end
end
