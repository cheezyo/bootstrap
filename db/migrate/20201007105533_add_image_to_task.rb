class AddImageToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :image, :string
  end
end
