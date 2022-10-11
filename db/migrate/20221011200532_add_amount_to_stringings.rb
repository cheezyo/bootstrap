class AddAmountToStringings < ActiveRecord::Migration[6.0]
  def change
    add_column :stringings, :amount, :integer
    add_column :stringings, :comment, :text
  end
end
