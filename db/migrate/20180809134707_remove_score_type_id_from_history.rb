class RemoveScoreTypeIdFromHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :histories, :score_type_id
  end
end
