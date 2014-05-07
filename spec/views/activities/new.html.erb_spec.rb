require 'spec_helper'

describe "activities/new" do
  before(:each) do
    assign(:activity, stub_model(Activity,
      :body => "MyText",
      :last_import => false
    ).as_new_record)
  end

  it "renders new activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", activities_path, "post" do
      assert_select "textarea#activity_body[name=?]", "activity[body]"
      assert_select "input#activity_last_import[name=?]", "activity[last_import]"
    end
  end
end
