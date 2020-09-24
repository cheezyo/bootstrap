class AddSeniorU10ToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :u10, :boolean
    add_column :tournaments, :senior, :boolean
  end
end
