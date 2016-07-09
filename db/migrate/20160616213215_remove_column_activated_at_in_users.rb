class RemoveColumnActivatedAtInUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :activated_at
  end
end
