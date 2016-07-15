class ChangeColumnDateFromDateToDatetimeWeights < ActiveRecord::Migration[5.0]
  def change
    change_column :weights , :date, :datetime
  end
end
