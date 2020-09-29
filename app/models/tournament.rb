class Tournament < ApplicationRecord
	has_many :player_tournaments, :dependent => :delete_all
	has_many :players, through: :player_tournaments
end
