class RenameColumnExameIdToExamIdInValores < ActiveRecord::Migration[5.0]
  def change
    rename_column :valores , :exame_id, :exam_id
  end
end
