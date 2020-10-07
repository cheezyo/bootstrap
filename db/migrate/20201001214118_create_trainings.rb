class CreateTrainings < ActiveRecord::Migration[6.0]
  def change
    create_table :trainings do |t|
      t.integer :type_of_training_id
      t.float :time
      t.date :t_date
      t.string :coment_text

      t.timestamps
    end
  end
end
