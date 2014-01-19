require 'spec_helper'

describe "goals/show" do
  before(:each) do
    @goal = assign(:goal, stub_model(Goal,
      :body => "Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Body/)
  end
end
