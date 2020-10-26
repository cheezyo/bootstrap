class AddPropertiesForPlanets < ActiveRecord::Migration[6.0]
  def change
  	add_column :planets, :diary, :boolean
  	add_column :planets, :ironman, :boolean
  	add_column :planets, :utr, :boolean
  	add_column :planets, :events, :boolean
  	add_column :planets, :stats, :boolean
  end
end
