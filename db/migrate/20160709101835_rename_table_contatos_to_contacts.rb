class RenameTableContatosToContacts < ActiveRecord::Migration[5.0]
  def change
    rename_table :contatos, :contacts
  end
end
