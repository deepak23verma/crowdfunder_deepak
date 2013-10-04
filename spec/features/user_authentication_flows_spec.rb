require 'spec_helper'

describe "User Authentication" do
  describe "when visting the sign in page" do
    
    it "should successfully register a user" do
      
      visit "/users/new"
      expect(current_path).to eq(new_user_path)

      # expect there is a link to a nav to Sign Up
      within(:css, '.navbar') do
      	find_link("Sign up").visible?
      end

      user = FactoryGirl.build(:user)

      #Fill in the from with the info from user created by FactoryGirl
      fill_in "user[email]", :with => user.email
      fill_in "user[first_name]", :with => user.first_name
      fill_in "user[last_name]", :with => user.last_name
      fill_in "user[password]", :with => user.password
      click_button "Create Account"

      # After submitting the form, should be redirected to root
      expect(current_path).to eq(root_path)
      # While a message says "Account created"
      expect(page).to have_content("Account created")
      # And the nav no longer has a link to a Sign Up but Logout
      within(:css, '.navbar') do
      	has_no_link?('Sign up')
      	has_link?('Logout')
      end
    end

    it "should fail registration" do
    	visit "/users/new"
    	user = FactoryGirl.build(:user)

    	#Invalid form submission...
    	fill_in "user[email]", :with => user.email
    	click_button "Create Account"
    	# Should redirect to user_path and ...
    	expect(current_path).to eq(users_path)
    	#... no message saying "Account created" should appear
    	expect(page).to have_no_content("Account created")

    	within(:css, '.alert') do
    		have_content("Please try again")
    	end
    end

  	it "should successfully log in" do
  		visit '/'
  		find('.navbar').has_no_link?('Logout').should be_true
  		# Calling the helper method here, and it returns a user
  		user = setup_signed_in_user
  		find('.navbar').has_link?('Logout').should be_true
  	end

  	it "should unsuccessfully log in" do
  		visit '/sessions/new'

  		fill_in "email", with: "a@b.com"
  		fill_in "password", with: "invalid creds"
  		click_button "Log in"

  		expect(current_path).to eq(sessions_path)

  		expect(page).to have_content('Invalid')
  	end

  	it "should successfully logout" do
  		# Calling the helper method again
  		user = setup_signed_in_user

  		visit '/'

  		find('.navbar').click_link 'Logout'

  		expect(page).to have_content('logged out')
  		find('.navbar').has_no_link?('Logout')
  	end
  end
end
