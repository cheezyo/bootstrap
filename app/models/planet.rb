class Planet < ApplicationRecord
	has_many :players
	has_many :users, through: :planet_coaches

end
