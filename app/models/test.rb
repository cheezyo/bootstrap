class Test < ApplicationRecord
	belongs_to :player
	belongs_to :test_group

def self.get_sprint_score(gender)
	max = 2.85
	low = 4.15
	
	if gender == "female"
		max = 3.15
		low = 4.30
	end

	get_running_score(max, low, 100.00, 9, 1000)
end

def self.get_spider_score (gender)
	max = 14.00
	low = 23.90
	
	if gender == "female"
		max = 15.00
		low = 24.80
	end

	get_running_score(max, low, 100.00, 9, 1000) 
end

def self.get_jump_score (gender)
	max = 3.10
	low = 1.40
	
	if gender == "female"
		max = 2.70
		low = 1.00
	end
	get_count_score(max, low, 100.00, 5, 1000)
end

def self.get_throw_score (gender)
	max = 18.00
	low = 4.00
	
	if gender == "female"
		max = 13.50
		low = 4.00
	end
	get_count_score(max, low, 10.00, 3, 1000)
end


def self.get_box_score (gender)
	max = 115
	low = 20
	if gender == "female"
		max = 100
	end
	get_count_score(max, low, 1.00, 8, 1200)
end	

def self.get_beep_score (gender)
	max = 200
	low = 32
	if gender == "female"
		max = 171
		low = 32
	end
	get_count_score(max, low, 2.00, 9, 1200)
end

def self.get_chins_score (gender)

	max = 25
	low = -1 
	if gender == "female"
		max = 17
	end
	get_count_score(max, low, 1.00, max, 1200)
end

def self.get_situps_score (gender)
	max = 30
	low = -1
	if gender == "female"
		max = 25
	end
	get_count_score(max, low, 1.00, 100, 1200)
end

def self.get_pushups_score (gender)
	max = 85
	low = -1
	if gender == "female"
		max = 70
	end
	get_count_score(max, low, 1.00, 9, 1200)
end

def self.get_stretch_back_score (gender)
	max = 85
	low = 9
	if gender == "female"
		max = 85
		low = 10
	end
	get_count_score(max, low, 2.00, 9, 750)
end


def self.get_stretch_front_score (gender)
	max = 50
	low = 18
	if gender == "female"
		max = 50
		low = 18
	end
	get_count_score(max, low, 2.00, 9, 750)
end




def self.get_running_score ( max_in, low_in, interval, scoring_alg, total_points)
	total = total_points
	
	max = max_in
	low = low_in
	
	
	score_list = Hash.new
	score_per_rep = ((total / (low - max)) / interval).round(2)
	score_total = 0;
	low_hash_start = low
	n = 1
	b = scoring_alg
	while max <= low

		if n.odd? && n < b
			score_total = score_per_rep + score_total + n 
		elsif n.even? && n < b
			score_total = score_per_rep + score_total - n
		else
			score_total = score_per_rep + score_total
		end

		n+=1
		score_list[low_hash_start.round(2)] = score_total.round(1)
		max += (1.00 / interval)
		low_hash_start -= (1.00 / interval)

	end
	
	score_list
end

def self.get_count_score ( max_in, low_in, interval, scoring_alg, total_points)
	total = total_points
	max = max_in
	low = low_in
	score_list = Hash.new
	score_per_rep = ((total / (max - low)) / interval).round(2)
	score_total = 0;
	low_hash_start = low
	n = 1
	b = scoring_alg
	while low <= max
		if n.odd? 
			score_total = score_per_rep + score_total + n 
		elsif n.even? && n < b
			score_total = score_per_rep + score_total - n
		else
			score_total = score_per_rep + score_total
		end
		if n >= b
			n = 1
		else
			n+=1
		end 
		score_list[low_hash_start.round(2)] = score_total.round(1)
		low += (1.00 / interval)
		low_hash_start += (1.00 / interval)

	end
	
	score_list
end



end
