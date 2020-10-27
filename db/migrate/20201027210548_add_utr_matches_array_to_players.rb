class AddUtrMatchesArrayToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :utr_matches_array, :text
  end
end
