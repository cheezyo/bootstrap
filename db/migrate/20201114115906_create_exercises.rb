class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :title
      t.integer :year
      t.string :gender
      t.text :results

      t.timestamps
    end
  end
end
