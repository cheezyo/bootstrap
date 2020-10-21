class AddRatingToTranings < ActiveRecord::Migration[6.0]
  def change
    add_column :trainings, :rating, :integer
  end
end
