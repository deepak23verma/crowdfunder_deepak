class ProjectsController < ApplicationController
	# before_filter :require_login, :only => :edit

	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
	end

end
