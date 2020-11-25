class Planet < ApplicationRecord
	has_many :players
	has_many :users, through: :planet_coaches
	has_many :periodizations

	def create_periodization(id) 
		(1..52).each do |w|
			p = Periodization.new
			p.week = w
			p.planet_id = id
			p.tennis_intesity = 0
			p.physical_intesity = 0
			p.save

		end
	end

	def has_periodization? 
		! self.periodizations.empty? 
	end 

end
