require 'spec_helper'

describe "best_features/index" do
  before(:each) do
    assign(:best_features, [
      stub_model(BestFeature,
        :title => "Title",
        :description => "MyText",
        :image => "Image"
      ),
      stub_model(BestFeature,
        :title => "Title",
        :description => "MyText",
        :image => "Image"
      )
    ])
  end

  it "renders a list of best_features" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
