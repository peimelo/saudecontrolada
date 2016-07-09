class ExcluirColunaErrosCondoId < ActiveRecord::Migration
  def change
    remove_column :erros, :condo_id
  end
end
