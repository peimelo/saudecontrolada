class AddUniqueIndexOnWeights < ActiveRecord::Migration[5.0]
  def change
    add_index :weights, [:date, :user_id], unique: true
  end
end
