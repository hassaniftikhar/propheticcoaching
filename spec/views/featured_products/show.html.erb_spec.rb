require 'spec_helper'

describe "featured_products/show" do
  before(:each) do
    @featured_product = assign(:featured_product, stub_model(FeaturedProduct,
      :title => "Title",
      :description => "MyText",
      :image => "Image",
      :price => "9.99",
      :profile_id => "Profile",
      :profile_type => "Profile Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Image/)
    rendered.should match(/9.99/)
    rendered.should match(/Profile/)
    rendered.should match(/Profile Type/)
  end
end
