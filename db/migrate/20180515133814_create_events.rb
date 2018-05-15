class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :datetime
      t.string :title
      t.float :plan
      t.references :store, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
