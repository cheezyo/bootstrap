class AddCoachIdToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :coach_id, :integer
  end
end
