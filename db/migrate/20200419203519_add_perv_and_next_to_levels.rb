class AddPervAndNextToLevels < ActiveRecord::Migration[6.0]
  def change
    add_column :levels, :next_level, :integer
    add_column :levels, :prev_level, :integer
    add_column :stickers, :trophy, :boolean
  end
end
