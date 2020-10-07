class AddPlayerToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :player, :boolean
  end
end
