module SessionSupport
	# This is a helper method we can all anywhere in the tests
	def setup_signed_in_user
		pass = "this-is-a-password"
		user = FactoryGirl.create :user, password: pass
		visit '/sessions/new'

		fill_in "email", with: user.email
		fill_in "password", with: pass
		click_button "Log in"
		# Return our user when this method is called
		user
	end
end