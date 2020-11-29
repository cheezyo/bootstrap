class AddParentEmailToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :parent_email, :text
  end
end
