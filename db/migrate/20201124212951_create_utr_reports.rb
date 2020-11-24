class CreateUtrReports < ActiveRecord::Migration[6.0]
  def change
    create_table :utr_reports do |t|
      t.date :utr_date
      t.text :boys
      t.text :girls

      t.timestamps
    end
  end
end
