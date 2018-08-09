class DropScoreTypeTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :score_types
  end
end
