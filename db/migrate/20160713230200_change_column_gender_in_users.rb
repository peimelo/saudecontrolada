class ChangeColumnGenderInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :gender, :string, limit: 1
  end
end
