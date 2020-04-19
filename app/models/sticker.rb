class Sticker < ApplicationRecord
	has_many :player_stickers
	has_many :players, through: :player_stickers
	belongs_to :level 
end
