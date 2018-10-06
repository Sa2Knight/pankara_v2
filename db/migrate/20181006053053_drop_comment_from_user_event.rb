class DropCommentFromUserEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_events, :comment, :string
  end
end
