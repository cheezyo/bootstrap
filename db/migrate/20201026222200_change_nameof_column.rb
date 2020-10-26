class ChangeNameofColumn < ActiveRecord::Migration[6.0]
  def change
  	rename_column :players, :matches, :utr_stats
  end
end
