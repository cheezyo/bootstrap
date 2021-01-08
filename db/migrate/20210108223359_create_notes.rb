class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.text :note
      t.integer :player_id
      t.integer :user_id

      t.timestamps
    end
  end
end
