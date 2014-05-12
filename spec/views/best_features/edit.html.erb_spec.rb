require 'spec_helper'

describe "best_features/edit" do
  before(:each) do
    @best_feature = assign(:best_feature, stub_model(BestFeature,
      :title => "MyString",
      :description => "MyText",
      :image => "MyString"
    ))
  end

  it "renders the edit best_feature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", best_feature_path(@best_feature), "post" do
      assert_select "input#best_feature_title[name=?]", "best_feature[title]"
      assert_select "textarea#best_feature_description[name=?]", "best_feature[description]"
      assert_select "input#best_feature_image[name=?]", "best_feature[image]"
    end
  end
end
