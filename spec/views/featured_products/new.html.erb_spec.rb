require 'spec_helper'

describe "featured_products/new" do
  before(:each) do
    assign(:featured_product, stub_model(FeaturedProduct,
      :title => "MyString",
      :description => "MyText",
      :image => "MyString",
      :price => "9.99",
      :profile_id => "MyString",
      :profile_type => "MyString"
    ).as_new_record)
  end

  it "renders new featured_product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", featured_products_path, "post" do
      assert_select "input#featured_product_title[name=?]", "featured_product[title]"
      assert_select "textarea#featured_product_description[name=?]", "featured_product[description]"
      assert_select "input#featured_product_image[name=?]", "featured_product[image]"
      assert_select "input#featured_product_price[name=?]", "featured_product[price]"
      assert_select "input#featured_product_profile_id[name=?]", "featured_product[profile_id]"
      assert_select "input#featured_product_profile_type[name=?]", "featured_product[profile_type]"
    end
  end
end
