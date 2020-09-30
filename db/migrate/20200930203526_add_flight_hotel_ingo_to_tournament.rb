class AddFlightHotelIngoToTournament < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :flight_hotel, :text
    add_column :tournaments, :commet, :text
  end
end
