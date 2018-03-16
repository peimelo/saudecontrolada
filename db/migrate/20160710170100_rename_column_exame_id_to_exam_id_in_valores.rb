class RenameColumnExameIdToExamIdInValores < ActiveRecord::Migration[5.1]
  def change
    rename_column :valores , :exame_id, :exam_id
  end
end
