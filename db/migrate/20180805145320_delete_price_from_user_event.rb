class DeletePriceFromUserEvent < ActiveRecord::Migration[5.2]
  def up
    remove_column :user_events, :price, :integer
  end
  def down
    add_column :user_events, :price, :integer
  end
end
