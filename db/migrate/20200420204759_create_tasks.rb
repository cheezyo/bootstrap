class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :task
      t.integer :task_category_id
      t.integer :player_id
      t.boolean :done
      t.date :done_date
      t.integer :progress

      t.timestamps
    end
  end
end
