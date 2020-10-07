class AddUserIdToTraining < ActiveRecord::Migration[6.0]
  def change
    add_column :trainings, :user_id, :integer
  end
end
