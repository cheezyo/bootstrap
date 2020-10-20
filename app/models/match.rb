class Match < ApplicationRecord
	mount_uploader :image, ImageUploader 
	belongs_to :player
end
