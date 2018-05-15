class CreateScoreTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :score_types do |t|
      t.string :brand
      t.string :name

      t.timestamps
    end
  end
end
