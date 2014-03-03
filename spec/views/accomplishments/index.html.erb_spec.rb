require 'spec_helper'

describe "accomplishments/index" do
  before(:each) do
    assign(:accomplishments, [
      stub_model(Accomplishment,
        :body => "MyText",
        :mentee_id => 1
      ),
      stub_model(Accomplishment,
        :body => "MyText",
        :mentee_id => 1
      )
    ])
  end

  it "renders a list of accomplishments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
