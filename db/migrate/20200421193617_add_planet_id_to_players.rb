class AddPlanetIdToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :planet_id, :integer
  end
end
