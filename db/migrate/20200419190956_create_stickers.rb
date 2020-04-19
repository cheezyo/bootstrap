class CreateStickers < ActiveRecord::Migration[6.0]
  def change
    create_table :stickers do |t|
      t.string :name
      t.integer :level_id

      t.timestamps
    end
  end
end
