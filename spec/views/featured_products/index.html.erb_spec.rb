require 'spec_helper'

describe "featured_products/index" do
  before(:each) do
    assign(:featured_products, [
      stub_model(FeaturedProduct,
        :title => "Title",
        :description => "MyText",
        :image => "Image",
        :price => "9.99",
        :profile_id => "Profile",
        :profile_type => "Profile Type"
      ),
      stub_model(FeaturedProduct,
        :title => "Title",
        :description => "MyText",
        :image => "Image",
        :price => "9.99",
        :profile_id => "Profile",
        :profile_type => "Profile Type"
      )
    ])
  end

  it "renders a list of featured_products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Profile".to_s, :count => 2
    assert_select "tr>td", :text => "Profile Type".to_s, :count => 2
  end
end
