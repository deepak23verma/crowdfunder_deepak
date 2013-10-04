require 'spec_helper'

describe Pledge do
  it "should require a user" do
  	pledge = FactoryGirl.build(:pledge, user: nil)

  	# Should not be able to save
  	pledge.should_not == pledge.save

  	expect(pledge).to have(1).errors_on(:user_id)
  end
end
