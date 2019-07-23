class RemoveColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :status
    remove_column :tasks, :priority
  end
end
