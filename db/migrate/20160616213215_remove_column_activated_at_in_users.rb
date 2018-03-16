class RemoveColumnActivatedAtInUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :activated_at
  end
end
