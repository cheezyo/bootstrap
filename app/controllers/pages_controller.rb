class PagesController < ApplicationController

	def index
	if current_user.present?

     else
      redirect_to '/my/users/sign_in'
     end
	end

	def task_report
	if @current_user.admin? 
		@tasks = Array.new
		Task.all.group_by{|x| x.created_at.strftime("%Y-%m-%d")}.each do |t|
			@tasks << [t[0], t[1].count]
		end
	else
		redirect_to root_url, notice: "You are not authorized to access this page"
	end
		
	end

	def diary_report
	if @current_user.admin? 
		@tasks = Array.new
		Task.all.group_by{|x| x.created_at.strftime("%Y-%m-%d")}.each do |t|
			@tasks << [t[0], t[1].count]
		end
	else
		redirect_to root_url, notice: "You are not authorized to access this page"
	end
		
	end

	def diary_report
		players = Array.new
		Planet.where(diary: true).each do |p|
			players << p.players.pluck(:id)
		end
		@players = Player.find(players)
		@date = DateTime.now 
		if params[:date]
			@date = DateTime.parse(params[:date])
		end
	end



end
