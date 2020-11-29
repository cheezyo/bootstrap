class AddFeedbackToPlanet < ActiveRecord::Migration[6.0]
  def change
    add_column :planets, :feedback, :boolean
  end
end
