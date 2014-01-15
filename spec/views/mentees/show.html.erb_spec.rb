require 'spec_helper'

describe "mentees/show" do
  before(:each) do
    @mentee = assign(:mentee, stub_model(Mentee,
      :index => "Index",
      :show => "Show"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Index/)
    rendered.should match(/Show/)
  end
end
