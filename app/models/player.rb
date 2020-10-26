
class Player < ApplicationRecord
	include HTTParty
	belongs_to :level
	belongs_to :planet
	has_many :tasks
	has_many :user_players
	has_many :users, through: :user_players
	has_many :tests, :dependent => :delete_all
	has_many :player_stickers
	has_many :stickers, through: :player_stickers, :dependent => :delete_all
	has_many :player_tournaments, :dependent => :delete_all
	has_many :tournaments, through: :player_tournaments
	has_many :matches, :dependent => :delete_all

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

	def got_utr_profile?
		! self.utr_profile.nil? && ! self.utr_profile.blank?
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
		self.tests.order(:test_date, :desc).first rescue nil
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
	def get_training_this_year
		self.user.trainings.where('t_date BETWEEN ? AND ?', DateTime.now - 12.months, DateTime.now).sum(:time)
	end
	def get_training_this_month 
		self.user.trainings.where('t_date BETWEEN ? AND ?', DateTime.now.at_beginning_of_month, DateTime.now.at_end_of_month).sum(:time)
	end
	def get_tasks_last_year
		self.tasks.where('created_at BETWEEN ? AND ?', DateTime.now - 12.months, DateTime.now)
	end

	def get_match_reports 
		self.matches.where('created_at BETWEEN ? AND ?', DateTime.now - 12.months, DateTime.now).count
	end
	def get_utr
		stats = "https://agw-prod.myutr.com/v1/player/" + self.utr_profile + "/stats?Months=12&Type=singles&resultType=myutr&fetchAllResults=true"
		json_stats = HTTParty.get(stats, headers: {"Authorization" => get_token})
		return json_stats.parsed_response["singlesUtr"]
	end
	def get_matches
		
		matches = "https://agw-prod.myutr.com/v1/player/" + self.utr_profile + "/results?year=last&Type=singles"
		json_matches = HTTParty.get(matches, headers: {"Authorization" => get_token})
		arr = Array.new
		arr << json_matches.parsed_response["wins"].to_i
		arr << json_matches.parsed_response["losses"].to_i
		arr << arr[0] + arr[1]
		if arr[2] > 0 
		arr << ((arr[0].to_f / arr[2].to_f) * 100.00).round(2)
		else
		arr << 0
		end

		return arr
	end

	 def get_token 
    	string = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJNZW1iZXJJZCI6IjEyOTQxMCIsImVtYWlsIjoiY2V6YXJzaW5jYW5AaG90bWFpbC5jb20iLCJWZXJzaW9uIjoiMSIsIkRldmljZUxvZ2luSWQiOiI0NzMyNTQ2IiwibmJmIjoxNjAxNDUyNzIzLCJleHAiOjE2MDQwNDQ3MjMsImlhdCI6MTYwMTQ1MjcyM30.phM9zNHzbAfqMQtcivh90nB6nfCeHWPGFbsCoQil6AA"
  	end



end
