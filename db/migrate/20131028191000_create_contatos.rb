class CreateContatos < ActiveRecord::Migration
  def change
    create_table :contatos do |t|
      t.string :nome
      t.string :email,    :null => false
      t.string :telefones
      t.text   :mensagem, :null => false
      t.string :ip

      t.timestamps
    end
  end
end
