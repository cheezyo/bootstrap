class ChangeTypeStringing < ActiveRecord::Migration[6.0]
  def change
  	change_column :stringings, :tension, :string
  end
end
