require 'spec_helper'

describe "best_features/new" do
  before(:each) do
    assign(:best_feature, stub_model(BestFeature,
      :title => "MyString",
      :description => "MyText",
      :image => "MyString"
    ).as_new_record)
  end

  it "renders new best_feature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", best_features_path, "post" do
      assert_select "input#best_feature_title[name=?]", "best_feature[title]"
      assert_select "textarea#best_feature_description[name=?]", "best_feature[description]"
      assert_select "input#best_feature_image[name=?]", "best_feature[image]"
    end
  end
end
