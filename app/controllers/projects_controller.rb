class ProjectsController < ApplicationController
	# before_filter :require_login, :only => :edit

	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
	end

	def nav_state
		@nav = :projects
	end

end
