class AddPlayerAccessToPlanet < ActiveRecord::Migration[6.0]
  def change
    add_column :planets, :player_access, :boolean
  end
end
