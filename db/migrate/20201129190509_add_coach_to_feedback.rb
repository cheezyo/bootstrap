class AddCoachToFeedback < ActiveRecord::Migration[6.0]
  def change
    add_column :feedbacks, :coach, :string
  end
end
