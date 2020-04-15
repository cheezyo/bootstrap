class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.float :sprint
      t.float :spider
      t.float :jump
      t.float :fh_throw
      t.float :bh_throw
      t.integer :box
      t.integer :player_id
      t.integer :test_group_id
      t.integer :chins
      t.integer :situps
      t.integer :pushups
      t.float :back_stretch
      t.float :front_stretch
      t.float :test_score
      t.float :beep
      t.string :gender
      t.string :test_type
      t.integer :age
      t.integer :program1
      t.integer :program2

      t.timestamps
    end
  end
end
