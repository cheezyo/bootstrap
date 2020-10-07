class ChangeColumnType < ActiveRecord::Migration[6.0]
  def change
  	change_column :trainings, :time, :integer
  end
end
