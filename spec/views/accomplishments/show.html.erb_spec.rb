require 'spec_helper'

describe "accomplishments/show" do
  before(:each) do
    @accomplishment = assign(:accomplishment, stub_model(Accomplishment,
      :body => "MyText",
      :mentee_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
