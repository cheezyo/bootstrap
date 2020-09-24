class AddClubTripToTournament < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :club_trip, :boolean
  end
end
