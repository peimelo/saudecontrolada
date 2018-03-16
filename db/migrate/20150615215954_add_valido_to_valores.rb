class AddValidoToValores < ActiveRecord::Migration[5.1]
  def change
    add_column :valores, :valido, :boolean, null: false, default: true
  end
end
