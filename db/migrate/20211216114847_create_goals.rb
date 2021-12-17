class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.integer :player_id
      t.text :short_one
      t.text :short_two
      t.text :short_three
      t.text :medium_one
      t.text :medium_two
      t.text :long
      t.text :dream

      t.timestamps
    end
  end
end
