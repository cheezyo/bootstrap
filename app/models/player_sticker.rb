class PlayerSticker < ApplicationRecord
	belongs_to :player
	belongs_to :sticker
end
