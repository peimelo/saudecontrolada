class RenameTableExamesToExams < ActiveRecord::Migration[5.1]
  def change
    rename_table :exames, :exams
  end
end
