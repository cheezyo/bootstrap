class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :player_id
      t.string :opponent
      t.text :comment
      t.string :image

      t.timestamps
    end
  end
end
