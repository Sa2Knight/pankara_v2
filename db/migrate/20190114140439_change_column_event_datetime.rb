class ChangeColumnEventDatetime < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :datetime, :date
    change_column :events, :date, :date
  end
end
