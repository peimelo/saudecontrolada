class RenameColumnExameIdToExamIdInExamsResults < ActiveRecord::Migration[5.0]
  def change
    rename_column :exams_results , :exame_id, :exam_id
  end
end
