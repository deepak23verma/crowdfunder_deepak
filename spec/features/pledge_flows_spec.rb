require 'spec_helper'

describe "Pledge Listing" do
  describe "when visting the pledge page" do
    before(:each) do
    	@project = FactoryGirl.create :project
    end

    it "should require a authenticated user" do
    	visit project_path(@project)

    	click_link 'Back This Project'

    	expect(current_path).to eq(new_session_path)
    	expect(page).to have_content("Please login first")
    end

    it "authenticated user can pledge valid amount" do
    	user = setup_signed_in_user

    	visit project_path(@project)
    	click_link 'Back This Project'

    	# Should be at pledge submission page, with 0 pledges in the databases currently
    	expect(current_path).to eq(new_project_pledge_path(@project))
    	expect(Pledge.count).to eq(0)

    	fill_in 'pledge[amount]', with: 100
    	click_button 'Pledge Now'

    	# Should be redirected back to project page with thank you message
    	expect(current_path).to eq(project_path(@project))

    	expect(page).to have_content("Thanks for pledging")

    	# Verify that the pledge was created with the right attributes
    	pledge = Pledge.order(:id).last

    	pledge.user.should == user
    	expect(pledge.user).to eq(user)

    	pledge.project.should == @project
    	expect(pledge.project).to eq(@project)

    	pledge.amount.should == 100
    	expect(pledge.amount).to eq(100)
    end

    it "should let an authenticated user pledge a valid amount" do
        expect(last_email.to).to eq([@project.user.email])
    end
  end
end
