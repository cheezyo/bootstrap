class Level < ApplicationRecord
	has_many :players 
	has_many :stickers


	def got_stickers?
		!self.stickers.empty? 
	end
end
