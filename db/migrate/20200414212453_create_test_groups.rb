class CreateTestGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :test_groups do |t|
      t.string :title
      t.date :date

      t.timestamps
    end
  end
end
