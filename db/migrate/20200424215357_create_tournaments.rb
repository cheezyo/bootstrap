class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :title
      t.string :url
      t.boolean :u11
      t.boolean :u12
      t.boolean :u13
      t.boolean :u14
      t.boolean :u15
      t.boolean :u16
      t.boolean :u19

      t.timestamps
    end
  end
end
