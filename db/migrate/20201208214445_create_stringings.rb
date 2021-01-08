class CreateStringings < ActiveRecord::Migration[6.0]
  def change
    create_table :stringings do |t|
      t.string :customer
      t.string :type_of_strings
      t.string :tension
      t.float :price
      t.date :done
      t.integer :delivered
      t.date :pick_up
      t.date :paid
      t.integer :registered_by
      t.integer :payment_registration
      t.string :payment_type

      t.timestamps
    end
  end
end
