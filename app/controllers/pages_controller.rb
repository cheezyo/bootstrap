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
		Task.all.group_by{|x| x.created_at.strftime("%Y-%m-%d")}.each do |t|
			@tasks << [t[0], t[1].count]
		end

		@json_matches = HTTParty.get("https://agw-prod.myutr.com/v1/player/835762/results?year=last&Type=singles", headers: {"Authorization" => "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJNZW1iZXJJZCI6IjEyOTQxMCIsImVtYWlsIjoiY2V6YXJzaW5jYW5AaG90bWFpbC5jb20iLCJWZXJzaW9uIjoiMSIsIkRldmljZUxvZ2luSWQiOiI0NzMyNTQ2IiwibmJmIjoxNjAxNDUyNzIzLCJleHAiOjE2MDQwNDQ3MjMsImlhdCI6MTYwMTQ1MjcyM30.phM9zNHzbAfqMQtcivh90nB6nfCeHWPGFbsCoQil6AA"})
	end


end
