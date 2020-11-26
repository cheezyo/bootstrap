
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

	validates :name, presence: true
	validates :lastname, presence: true
	validates :gender, presence: true
	validates :competitor, presence: true
	validates :planet_id, presence: true
	validates :level_id, presence: true
	serialize :utr_stats
	serialize :utr_matches
	serialize :utr_matches_array

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
		self.tests.order(test_date: :desc).first rescue nil
	end

	def get_diff_from_last_test
		tests = self.tests.order(test_date: :desc).first(2)
		arr = Array.new
		if ! tests.nil? && tests.count > 1
			 diff = (tests.first.test_score - tests.last.test_score).round(1)
			 arr << diff
			 if diff > 0
			 	arr << "fas fa-arrow-up "
			 	arr << "green"
			 else
			 	arr << "fas fa-arrow-down"
			 	arr << "red"
			 end
			 return arr
		else
			return arr = [0.0,"NO", "#000"]
		end
	end

	def get_rating
		rating = ""
    	face = Array.new
    	
	    if self.got_user?
	      rating = self.user.trainings.where(t_date: (DateTime.now - 7.days)..DateTime.now).pluck(:rating)
	      rating = rating.map(&:to_f)
	      if rating.count > 0 
	        rating1 = rating.sum / rating.count
	        case rating1

	        when 0..1.5 
	          face << "far fa-frown fa-1x"
	          face << 1
	        when 1.6..2.5
	          face << "far fa-meh fa-1x"
	          face << 2
	        when 2.6..3.5
	          face << "far fa-grin-alt fa-1x"
	          face << 3
	        when 3.6..4
	          face << "far fa-grin-hearts fa-1x"
	          face << 4
	        end
	    
	     	
	      end
	    end
	    if face.count <= 0 
	    	face  << "far fa-times-circle fa-1x"
    		face << 0
    	end
	    face
	end

	def get_training_programs
		last_ironman = get_last_ironman
		if last_ironman.program1 != nil && last_ironman.program2 != nil 
			arr = Array.new
			program1 = TrainingProgram.where(prog_number: last_ironman.program1).first
			program2 = TrainingProgram.where(prog_number: last_ironman.program2).first
			arr = [program1.prog_name, program1.prog_url, program2.prog_name, program2.prog_url]
		elsif last_ironman.program1 == 99
			arr = ["Empty", "Du har gjennomført ny test men, pga. skader skal du fokusere på skadeforbyggende program fra fysio.", "Empty", "Ingen test"]
		else
			arr = ["Empty", "Du har gjennomført ny test, program er ikke oppdatert av trener enda.", "Empty", "Ingen test"]
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
	def do_it 

		Player.all.reject{|p| ! p.got_utr_profile?}.each do |player|
			player.utr_stats = get_utr1(player)
			json_matches = get_json_matches(player)
			player.utr_matches = json_matches
			player.utr_matches_array = get_matches1(json_matches)
			player.save!
		end
		

	end
	def save_utr_age_groups_last
		boys_arr = Array.new
		girls_arr = Array.new

		(14..20).each do |i| 
			year = DateTime.now.year - i 
			start_date = DateTime.parse("01-01-" + year.to_s)
			end_date = DateTime.parse("31-12-" + year.to_s)
			boys_arr << Player.where(:age => start_date..end_date).where(gender: "male").reject{|p| ! p.got_utr_profile?}
			girls_arr << Player.where(:age => start_date..end_date).where(gender: "female").reject{|p| ! p.got_utr_profile?}
		end

		utr_boys = Array.new
		boys_arr.each do |age_grp|
			grp_arr = Array.new 
			age_grp.each do |p|
				grp_arr << p.utr_stats["startRating"]
			end
			utr_boys << grp_arr
		end 
		utr_girls = Array.new
		girls_arr.each do |age_grp|
			grp_arr = Array.new 
			age_grp.each do |p|
				grp_arr << p.utr_stats["startRating"]
			end
			utr_girls << grp_arr
		end 

		players_arr = Array.new
		players_arr << utr_boys
		players_arr << utr_girls
		utr_rep = UtrReport.new
		utr_rep.utr_date = DateTime.now - 1.year
		utr_rep.boys = utr_boys
		utr_rep.girls = utr_girls
		utr_rep.save


	end
	def save_utr_age_groups_last_this
		boys_arr = Array.new
		girls_arr = Array.new

		(13..19).each do |i| 
			year = DateTime.now.year - i 
			start_date = DateTime.parse("01-01-" + year.to_s)
			end_date = DateTime.parse("31-12-" + year.to_s)
			boys_arr << Player.where(:age => start_date..end_date).where(gender: "male").reject{|p| ! p.got_utr_profile?}
			girls_arr << Player.where(:age => start_date..end_date).where(gender: "female").reject{|p| ! p.got_utr_profile?}
		end

		utr_boys = Array.new
		boys_arr.each do |age_grp|
			grp_arr = Array.new 
			age_grp.each do |p|
				grp_arr << p.utr_stats["singlesUtr"]
			end
			utr_boys << grp_arr
		end 
		utr_girls = Array.new
		girls_arr.each do |age_grp|
			grp_arr = Array.new 
			age_grp.each do |p|
				grp_arr << p.utr_stats["singlesUtr"]
			end
			utr_girls << grp_arr
		end 

		players_arr = Array.new
		players_arr << utr_boys
		players_arr << utr_girls
		utr_rep = UtrReport.new
		utr_rep.utr_date = DateTime.now
		utr_rep.boys = utr_boys
		utr_rep.girls = utr_girls
		utr_rep.save


	end
	def get_json_matches(player)
		matches = "https://agw-prod.myutr.com/v1/player/" + player.utr_profile + "/results?year=last&Type=singles"
		json_matches = HTTParty.get(matches, headers: {"Authorization" => get_token})
		return json_matches.parsed_response
	end
	def get_utr1(player)
		stats = "https://agw-prod.myutr.com/v1/player/" + player.utr_profile + "/stats?Months=12&Type=singles&resultType=myutr&fetchAllResults=true"
		json_stats = HTTParty.get(stats, headers: {"Authorization" => get_token})
		return json_stats.parsed_response
	end
	def get_matches1(json_matches)		
		arr = Array.new
		arr << json_matches["wins"].to_i
		arr << json_matches["losses"].to_i
		arr << arr[0] + arr[1]
		if arr[2] > 0 
		arr << ((arr[0].to_f / arr[2].to_f) * 100.00).round(2)
		else
		arr << 0
		end

		return arr
	end

	 def get_token 
    	string = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJNZW1iZXJJZCI6IjEyOTQxMCIsImVtYWlsIjoiY2V6YXJzaW5jYW5AaG90bWFpbC5jb20iLCJWZXJzaW9uIjoiMSIsIkRldmljZUxvZ2luSWQiOiI1MDA2NDU1IiwibmJmIjoxNjA0MDU0OTA4LCJleHAiOjE2MDY2NDY5MDgsImlhdCI6MTYwNDA1NDkwOH0.NK4QbMZfrqfsz0JAs9IGTzbD6_svTCkBXNjHrFhH3zk"
  	end                  



end