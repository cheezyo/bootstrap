class ChagneRatingTrainings < ActiveRecord::Migration[6.0]
  def change
  	change_column :trainings, :rating, :string
  end
end
