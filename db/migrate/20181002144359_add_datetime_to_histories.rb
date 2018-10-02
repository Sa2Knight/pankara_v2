class AddDatetimeToHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :event_date, :date, after: :user_event_id
  end
end
