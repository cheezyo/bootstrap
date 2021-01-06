class AddReceptionistToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :receptionist, :boolean
  end
end
