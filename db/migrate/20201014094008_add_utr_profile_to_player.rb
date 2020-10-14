class AddUtrProfileToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :utr_profile, :string
  end
end
