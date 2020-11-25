class AddPeriodizationToPlanet < ActiveRecord::Migration[6.0]
  def change
    add_column :planets, :periodization, :boolean
  end
end
