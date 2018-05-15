class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.references :artist, foreign_key: true
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
