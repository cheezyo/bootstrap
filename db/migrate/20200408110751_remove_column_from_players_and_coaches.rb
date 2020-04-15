class RemoveColumnFromPlayersAndCoaches < ActiveRecord::Migration[6.0]
  def change

    remove_column :players, :user_id
    
  end
end
