class AddPlussToTournament < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :pluss, :boolean
  end
end
