class Goal < ApplicationRecord
	belongs_to :player
	



def player_profile
	ids = UserPlayer.where(player_id: self.player_id).pluck(:user_id)
	user = User.find(ids).reject{|u| u.coach == true || u.admin == true || u.parent == true || u.helper_coach == true || u.receptionist == true}
	user.first
end

end
