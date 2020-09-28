class AddTaskIdToTaskComment < ActiveRecord::Migration[6.0]
  def change
    add_column :task_comments, :task_id, :integer
  end
end
