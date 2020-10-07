class Training < ApplicationRecord
	belongs_to :user
	belongs_to :type_of_training
end
