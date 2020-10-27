class PagesController < ApplicationController

	def index
		
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


end
