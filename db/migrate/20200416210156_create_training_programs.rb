class CreateTrainingPrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :training_programs do |t|
      t.integer :prog_number
      t.string :prog_url
      t.string :prog_name

      t.timestamps
    end
  end
end
