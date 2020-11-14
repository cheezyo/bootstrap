class AddCountToTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :count, :boolean
  end
end
