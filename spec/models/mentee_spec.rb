require 'spec_helper'

describe Mentee do
		 it "has a valid factory" do 
		 	FactoryGirl.create(:mentee).should be_valid 
		 end
  it "is invalid without a first name" do 
  	FactoryGirl.build(:mentee, first_name: nil).should be_valid 
  end
end
