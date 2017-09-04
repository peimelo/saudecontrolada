class RenameColumnMensagemToMessageInContatos < ActiveRecord::Migration[5.1]
  def change
    rename_column :contatos, :mensagem, :message
  end
end
