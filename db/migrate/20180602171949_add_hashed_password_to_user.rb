class AddHashedPasswordToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hashed_password, :string, after: :id
  end
end
