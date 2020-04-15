class AddCoachParentToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :coach, :boolean, default: false
    add_column :users, :parent, :boolean, default: false
  end
end
