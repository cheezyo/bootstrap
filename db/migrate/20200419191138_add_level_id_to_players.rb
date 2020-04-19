class AddLevelIdToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :level_id, :integer
  end
end
