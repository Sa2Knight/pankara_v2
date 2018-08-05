class DeleteStoreRefFromEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :store_id, :integer
  end
end
