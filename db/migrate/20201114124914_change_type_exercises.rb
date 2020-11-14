class ChangeTypeExercises < ActiveRecord::Migration[6.0]
  def change
  	change_column :exercises, :type_of_exercise_id, :integer
  end
end
