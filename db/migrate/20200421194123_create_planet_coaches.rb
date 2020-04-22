class CreatePlanetCoaches < ActiveRecord::Migration[6.0]
  def change
    create_table :planet_coaches do |t|
      t.integer :user_id
      t.integer :planet_id

      t.timestamps
    end
  end
end
