class ExcluirColunaErrosCondoId < ActiveRecord::Migration[5.1]
  def change
    remove_column :erros, :condo_id
  end
end
