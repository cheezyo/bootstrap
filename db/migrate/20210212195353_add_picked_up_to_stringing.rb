class AddPickedUpToStringing < ActiveRecord::Migration[6.0]
  def change
    add_column :stringings, :picked_up, :boolean
  end
end
