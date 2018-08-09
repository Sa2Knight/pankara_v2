class AddProductToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :product, :integer, after: :title
  end
end
