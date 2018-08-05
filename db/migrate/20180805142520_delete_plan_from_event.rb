class DeletePlanFromEvent < ActiveRecord::Migration[5.2]
  def up
    remove_column :events, :plan, :float
  end
  def down
    add_column :events, :plan, :float
  end
end
