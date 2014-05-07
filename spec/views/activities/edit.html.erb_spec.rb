require 'spec_helper'

describe "activities/edit" do
  before(:each) do
    @activity = assign(:activity, stub_model(Activity,
      :body => "MyText",
      :last_import => false
    ))
  end

  it "renders the edit activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", activity_path(@activity), "post" do
      assert_select "textarea#activity_body[name=?]", "activity[body]"
      assert_select "input#activity_last_import[name=?]", "activity[last_import]"
    end
  end
end
