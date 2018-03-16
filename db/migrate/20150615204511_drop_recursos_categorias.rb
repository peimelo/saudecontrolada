class DropRecursosCategorias < ActiveRecord::Migration[5.1]
  def change
    drop_table :recursos_categorias
  end
end
