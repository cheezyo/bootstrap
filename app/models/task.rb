class Task < ApplicationRecord
	mount_uploader :image, ImageUploader 
	belongs_to :player
	belongs_to :task_category
	has_many :task_comments, :dependent => :delete_all

	def get_coach 
		User.find(self.coach_id)
	end 
end
