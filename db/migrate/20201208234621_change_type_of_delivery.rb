class ChangeTypeOfDelivery < ActiveRecord::Migration[6.0]
  def change
  	change_column :stringings, :delivered, :integer
  end
end
