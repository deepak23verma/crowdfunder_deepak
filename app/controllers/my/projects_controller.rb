class My::ProjectsController < ApplicationController
	before_filter :require_login
	before_filter :require_project, except: [:index, :new, :create]

	def index
		@projects = current_user.projects.order('projects.created_at DESC').all
	end

	def edit
	end

	def update
		if @project.update_attributes params[:project]
			 # redirect_to my_projects_path, notice: "Project updated!"
			 redirect_to [:my, :projects], notice: "Project updated!"
		else
			render :edit
		end
	end

	protected

	def require_project
		@project = current_user.projects.find(params[:id])
	end
end
