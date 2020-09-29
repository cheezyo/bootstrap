class CreatePlayerTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :player_tournaments do |t|
      t.integer :player_id
      t.integer :tournament_id

      t.timestamps
    end
  end
end
