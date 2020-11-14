class CreateTypeOfExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :type_of_exercises do |t|
      t.string :title

      t.timestamps
    end
  end
end
