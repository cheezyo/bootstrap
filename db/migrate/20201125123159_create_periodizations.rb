class CreatePeriodizations < ActiveRecord::Migration[6.0]
  def change
    create_table :periodizations do |t|
      t.integer :week
      t.text :tennis_focus
      t.integer :tennis_intesity
      t.text :physical_focus
      t.integer :physical_intesity
      t.integer :planet_id

      t.timestamps
    end
  end
end
