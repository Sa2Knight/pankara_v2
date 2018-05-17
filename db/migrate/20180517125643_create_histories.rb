class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.references :user_event, foreign_key: true
      t.references :song, foreign_key: true
      t.references :score_type, foreign_key: true
      t.integer :score
      t.integer :satisfaction
      t.integer :key
      t.text :comment

      t.timestamps
    end
  end
end
