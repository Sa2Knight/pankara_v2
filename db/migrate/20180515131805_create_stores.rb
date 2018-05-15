class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :branch
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
