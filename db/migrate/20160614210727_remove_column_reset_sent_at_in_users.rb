class RemoveColumnResetSentAtInUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :reset_sent_at
  end
end
