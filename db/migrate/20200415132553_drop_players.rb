class DropPlayers < ActiveRecord::Migration[6.0]
  def change
  	drop_table :players
  end
end
