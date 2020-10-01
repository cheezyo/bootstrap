class AddTestDateToTest < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :test_date, :date
  end
end
