class AddExameFkInExamesResultados < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :exames_resultados, :exames
  end
end
