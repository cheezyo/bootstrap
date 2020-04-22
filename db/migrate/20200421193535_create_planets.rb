class CreatePlanets < ActiveRecord::Migration[6.0]
  def change
    create_table :planets do |t|
      t.string :title
      t.string :age
      t.string :color
      t.integer :planet_coach_id

      t.timestamps
    end
  end
end
