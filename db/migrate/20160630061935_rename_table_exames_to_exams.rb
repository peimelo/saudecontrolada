class RenameTableExamesToExams < ActiveRecord::Migration[5.0]
  def change
    rename_table :exames, :exams
  end
end
