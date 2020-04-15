class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.date :age
      t.integer :user_id

      t.timestamps
    end
  end
end
