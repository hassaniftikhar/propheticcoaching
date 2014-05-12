require 'spec_helper'

describe "featured_products/edit" do
  before(:each) do
    @featured_product = assign(:featured_product, stub_model(FeaturedProduct,
      :title => "MyString",
      :description => "MyText",
      :image => "MyString",
      :price => "9.99",
      :profile_id => "MyString",
      :profile_type => "MyString"
    ))
  end

  it "renders the edit featured_product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", featured_product_path(@featured_product), "post" do
      assert_select "input#featured_product_title[name=?]", "featured_product[title]"
      assert_select "textarea#featured_product_description[name=?]", "featured_product[description]"
      assert_select "input#featured_product_image[name=?]", "featured_product[image]"
      assert_select "input#featured_product_price[name=?]", "featured_product[price]"
      assert_select "input#featured_product_profile_id[name=?]", "featured_product[profile_id]"
      assert_select "input#featured_product_profile_type[name=?]", "featured_product[profile_type]"
    end
  end
end
