class DropRecursosCategorias < ActiveRecord::Migration
  def change
    drop_table :recursos_categorias
  end
end
