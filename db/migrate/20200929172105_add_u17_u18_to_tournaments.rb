class AddU17U18ToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :u17, :boolean
    add_column :tournaments, :u18, :boolean
  end
end
