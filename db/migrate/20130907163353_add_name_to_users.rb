class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    change_column_null :users, :name, false
  end
end
