class AddDefaultToTasksStatusAndPriority < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, :string, default: 'pending', null: false
    change_column :tasks, :priority, :string, default: 'low', null: false
  end
end
