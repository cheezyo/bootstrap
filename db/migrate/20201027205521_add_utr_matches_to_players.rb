class AddUtrMatchesToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :utr_matches, :text
  end
end
