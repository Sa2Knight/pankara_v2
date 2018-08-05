class DropStoreTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :stores
  end
  def down
    create_table :stores do |t|
      t.string :name
      t.string :branch
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
