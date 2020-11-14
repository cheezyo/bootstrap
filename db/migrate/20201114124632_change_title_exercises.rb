class ChangeTitleExercises < ActiveRecord::Migration[6.0]
  def change
  	rename_column :exercises, :title, :type_of_exercise_id
  end
end
