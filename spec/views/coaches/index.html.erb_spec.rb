require 'spec_helper'

describe "coaches/index" do
  before(:each) do
    assign(:coaches, [
      stub_model(Coach,
        :index => "Index",
        :show => "Show"
      ),
      stub_model(Coach,
        :index => "Index",
        :show => "Show"
      )
    ])
  end

  it "renders a list of coaches" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Index".to_s, :count => 2
    assert_select "tr>td", :text => "Show".to_s, :count => 2
  end
end
