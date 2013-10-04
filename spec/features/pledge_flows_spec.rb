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
  end
end
