class AddExameFkInExamesResultados < ActiveRecord::Migration
  def change
    add_foreign_key :exames_resultados, :exames
  end
end
