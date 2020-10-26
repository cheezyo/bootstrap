class AddMatchesAndUtrToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :matches, :json
  end
end
