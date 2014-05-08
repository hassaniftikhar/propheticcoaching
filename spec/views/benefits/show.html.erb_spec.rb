require 'spec_helper'

describe "benefits/show" do
  before(:each) do
    @benefit = assign(:benefit, stub_model(Benefit,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end
end
