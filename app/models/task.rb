class Task < ApplicationRecord
	belongs_to :player
	belongs_to :task_category
	has_many :task_comments, :dependent => :delete_all
end
