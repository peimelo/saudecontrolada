class RemoveColumnActivateInUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :activated
  end
end
