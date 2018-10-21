class ChangeColumnTypeOfHistories < ActiveRecord::Migration[5.2]
  def change
    change_column :histories, :score, :float
  end
end
