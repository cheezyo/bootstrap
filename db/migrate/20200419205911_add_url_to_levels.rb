class AddUrlToLevels < ActiveRecord::Migration[6.0]
  def change
    add_column :levels, :url, :string
  end
end
