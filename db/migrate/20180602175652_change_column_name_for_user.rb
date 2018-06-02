class ChangeColumnNameForUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :user_name, :name
    rename_column :users, :hashed_password, :password_digest
  end
end
