class AddHelperCoachToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :helper_coach, :boolean
  end
end
