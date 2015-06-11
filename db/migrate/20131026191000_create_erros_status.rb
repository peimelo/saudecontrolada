class CreateErrosStatus < ActiveRecord::Migration
  def up
    create_table :erros_status do |t|
      t.string  :nome, :null => false
      t.string  :classe, :null => false
      t.string  :classe_badge, :null => false
    end

    execute "INSERT INTO erros_status VALUES (1, 'Em aberto', 'danger', 'danger');"
    execute "INSERT INTO erros_status VALUES (2, 'Em andamento', 'warning', 'warning');"
    execute "INSERT INTO erros_status VALUES (3, 'Corrigido', 'success', 'success');"
    execute "INSERT INTO erros_status VALUES (4, 'Cancelado', 'info', 'info');"

    add_index :erros_status, :nome, :unique => true
  end

  def down
    drop_table :erros_status
  end
end
