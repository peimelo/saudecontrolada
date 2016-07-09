class AddValidoToValores < ActiveRecord::Migration
  def change
    add_column :valores, :valido, :boolean, null: false, default: true
  end
end
