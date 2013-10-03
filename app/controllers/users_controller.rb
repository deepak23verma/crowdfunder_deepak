class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])

		if @user.save
			auto_login(@user)
			redirect_to root_url, :notice => "Account created"
		else
			render :new, :alert => "Invalid email or password"
		end

	end

end
