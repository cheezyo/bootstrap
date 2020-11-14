class Exercise < ApplicationRecord
	belongs_to :type_of_exercise
	serialize :results



	
	def create_types
		execs = [:sprint, :spider, :fh_throw, :bh_throw, :jump, :box, :chins, :pushups, :situps, :front_stretch, :back_stretch, :beep, :test_score]
		execs.each do |ex| 

			te = TypeOfExercise.new
			te.title = ex.to_s.capitalize
			te.save!
		end
	end
	def save_year(year)
		[:Male, :Female].each do |gender|
			self.save_year_method(gender, year)
		end

	end 
	def save_year_method(gender, year)
		execs = [:sprint, :spider, :fh_throw, :bh_throw, :jump, :box, :chins, :pushups, :situps, :front_stretch, :back_stretch, :beep, :test_score]
	    player_ids = Player.joins(:planet).where(planet_id: 1).pluck(:id)
	    tests = Test.where(player_id: player_ids).where('test_date BETWEEN ? AND ?',DateTime.parse("01-01-" + year.to_s), DateTime.parse("31-12-" + year.to_s))

	    #boys = Array.new
	    #girls = Array.new 
	    #execersie belongs_to age
	    execs.each do |ex|
	      execs_arr = Array.new 
	      (10..19).each do |n|
	        arr = Array.new
	        arr = tests.where(test_type: :Junior, age: n, gender: gender).pluck(ex)
	        age_arr = Array.new
	        age_arr << arr.min.to_f.truncate(2)
	        if ex != :chins
	          arr.delete(0.0)
	        end
	        age_arr << (arr.inject(0.0){ |sum, el| sum + el } / arr.count).truncate(2)
	        age_arr << arr.max.to_f.truncate(2)
	        execs_arr << age_arr
	      end
	      exec_results = Exercise.new
	      exec_results.type_of_exercise_id = TypeOfExercise.where(title: ex.capitalize).first.id
	      exec_results.year = year
	      exec_results.gender = gender.to_s
	      exec_results.results = execs_arr      
	      exec_results.save!
	      #boys << execs_arr
		end
	end

end
