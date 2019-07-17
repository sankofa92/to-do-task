class RemoveTaskStartAt < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :start_at
  end
end
