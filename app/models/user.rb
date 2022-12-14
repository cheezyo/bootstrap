class User < ApplicationRecord
 has_many :user_players
 has_many :players,through: :user_players
 has_many :planets,through: :planet_coaches
 has_many :tournaments
 has_many :trainings
  	#attr_accessor :id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

def no_roles? 
	! self.player? && ! self.parent? && ! self.helper_coach && ! self.coach? && ! self.admin? 
end


def get_player_profile
	self.players.first
end	

def got_profile?
	!self.players.empty?
end

def get_age
	 p = get_player_profile
	 age = Date.today.year - p.age.year
	 age -= 1 if Date.today < p.age + age.years
	 age
end	

def get_parent
	get_player_profile.users.select{|u| u.parent == true }.first
end

def get_coach
	get_player_profile.users.select{|u| u.coach == true || u.admin == true }.first
	#coach = help_to_fetch_my_relations("coach").first
	#coach
end

def got_coach?
	 !get_player_profile.users.select{|u| u.coach == true || u.admin == true }.empty? unless !got_profile?
	 #!help_to_fetch_my_relations("coach").empty? 
end	

def got_parent? 
	 !get_player_profile.users.select{|u| u.parent == true }.empty? unless !got_profile?
end





end
