class AddCoachToTournament < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :user_id, :integer
    add_column :tournaments, :only_coach, :boolean
  end
end
