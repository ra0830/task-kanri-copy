class ChangePeriodToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :period, 'date USING CAST(period AS date)'
  end
end
