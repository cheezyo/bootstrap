class CreatePlayerStickers < ActiveRecord::Migration[6.0]
  def change
    create_table :player_stickers do |t|
      t.integer :player_id
      t.integer :sticker_id

      t.timestamps
    end
  end
end
