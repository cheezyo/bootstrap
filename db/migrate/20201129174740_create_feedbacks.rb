class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.integer :player_id
      t.text :feed_back
      t.date :email_date

      t.timestamps
    end
  end
end
