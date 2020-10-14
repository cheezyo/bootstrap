class Training < ApplicationRecord
	belongs_to :user
	belongs_to :type_of_training

	validates :t_date, :presence => true
	validates :time, :presence => true
	validates :type_of_training_id, :presence => true
	
end
