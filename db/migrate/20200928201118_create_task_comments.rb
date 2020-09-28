class CreateTaskComments < ActiveRecord::Migration[6.0]
  def change
    create_table :task_comments do |t|
      t.text :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
