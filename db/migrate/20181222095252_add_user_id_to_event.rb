class AddUserIdToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :user_id, :bigint, after: :id
    add_foreign_key :events, :users, column: :user_id
  end
end
