require 'spec_helper'

describe "Project Listing" do
  describe "when visiting the index page" do
    it "should list only my projects" do
      me = setup_signed_in_user
      other_user = FactoryGirl.create :user

      3.times { FactoryGirl.create :project, user: me}
      2.times { FactoryGirl.create :project, user: other_user, title: "Other Dude's Project"}

      visit '/my/projects'

      expect(page).to have_selector('div.project', count: 3)

      expect(page).to have_no_content("Other Dude's Project")
    end

    it "should edit my project" do
    	me = setup_signed_in_user

    	project = FactoryGirl.create :project, user: me, title: "My Project"

    	visit edit_my_project_path(project)

    	fill_in 'project[title]', with: "It is really my project"

    	click_button('Update Project')

    	expect(current_path).to eq(my_projects_path)

    	expect(page).to have_content("It is really my project")
    end

  end
end
