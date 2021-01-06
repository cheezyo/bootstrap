class AddDoneByToStringing < ActiveRecord::Migration[6.0]
  def change
    add_column :stringings, :done_by, :integer
  end
end
