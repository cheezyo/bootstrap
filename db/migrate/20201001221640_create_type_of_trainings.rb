class CreateTypeOfTrainings < ActiveRecord::Migration[6.0]
  def change
    create_table :type_of_trainings do |t|
      t.string :title

      t.timestamps
    end
  end
end
