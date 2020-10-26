class ChangeTypeOfMatchesJsonToText < ActiveRecord::Migration[6.0]
  def change
  	change_column :players, :matches, :text
  end
end
