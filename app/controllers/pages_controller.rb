class PagesController < ApplicationController

	def index
		@arr = Array.new
		TypeOfTraining.all.each do |t|
			@arr << [t.title, Training.where(type_of_training: t.id, user_id: current_user.id).sum(:time)]
		end
		#@by_month = @current_user.trainings.group_by { |m| m.t_date.beginning_of_month }.sum(:time)
	end

	def task_report
		@tasks = Array.new
		Task.group_by{|x| x.created_at.strftime("%Y-%m-%d")}.each do |t|
			@tasks << [t[0], t[1].count]
		end
	end


end
