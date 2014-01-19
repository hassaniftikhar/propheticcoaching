require 'spec_helper'

describe "mentees/index" do
  before(:each) do
    assign(:mentees, [
      stub_model(Mentee,
        :index => "Index",
        :show => "Show"
      ),
      stub_model(Mentee,
        :index => "Index",
        :show => "Show"
      )
    ])
  end

  it "renders a list of mentees" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Index".to_s, :count => 2
    assert_select "tr>td", :text => "Show".to_s, :count => 2
  end
end
