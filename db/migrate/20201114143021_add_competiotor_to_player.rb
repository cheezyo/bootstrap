class AddCompetiotorToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :competitor, :boolean
  end
end
