class AddScoreTypeToHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :score_type, :integer, after: :song_id
  end
end
