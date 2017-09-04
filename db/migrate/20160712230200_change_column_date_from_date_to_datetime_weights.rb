class ChangeColumnDateFromDateToDatetimeWeights < ActiveRecord::Migration[5.1]
  def change
    change_column :weights , :date, :datetime
  end
end
