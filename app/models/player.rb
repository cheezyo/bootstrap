class Player < ApplicationRecord
	belongs_to :level
	has_many :user_players
	has_many :users, through: :user_players
	has_many :tests, :dependent => :delete_all
	has_many :player_stickers
	has_many :stickers, through: :player_stickers, :dependent => :delete_all
	def parent
		user_ids = UserPlayer.where(player_id: self.id).pluck(:user_id)
		parent = User.find(user_ids).select{|u| u.parent == true }
		parent.first
	end

	def player_profile
		ids = UserPlayer.where(player_id: self.id).pluck(:user_id)
		user = User.find(ids).reject{|u| u.coach == true || u.admin == true || u.parent == true}
		user.first
	end
	
	def fullname
    	self.name + " " + self.lastname 
	end
	def get_age

		now = Time.now.utc.to_date
		now.year - self.age.year - ((now.month > self.age.month || (now.month == self.age.month && now.day >= self.age.day)) ? 0 : 1)
	end

	def got_parent? 
		!self.users.select{|u| u.parent == true }.empty?
	end

	def got_coach? 
		!self.users.select{|u| u.coach == true || u.admin == true }.empty?
	end

	def got_user? 
		!self.users.select{|u| u.coach == false && u.admin == false && u.parent == false }.empty?
	end

	def user
		self.users.select{|u| u.coach == false && u.admin == false && u.parent == false }.first
	end

	def parent
		self.users.select{|u| u.parent == true }.first
	end

	def coach 
		self.users.select{|u| u.coach == true || u.admin == true }.first
	end

	def got_level? 
		!self.level_id.blank? 
	end
	def get_last_ironman
		self.tests.order(:asc).last rescue nil
	end


	def get_training_programs
		last_ironman = get_last_ironman
		if !last_ironman.nil? && !last_ironman.program1.nil? && !last_ironman.program2.nil? 
			arr = Array.new
			program1 = TrainingProgram.where(prog_number: last_ironman.program1).first
			program2 = TrainingProgram.where(prog_number: last_ironman.program2).first
			arr = [program1.prog_name, program1.prog_url, program2.prog_name, program2.prog_url]
		else
			arr = ["Empty", "Du har gjennomført ny test program er ikke oppdatert av trener enda.", "Empty", "Ingen test"]
		end

		

	end



end
