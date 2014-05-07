require 'spec_helper'

describe "exercises/new" do
  before(:each) do
    assign(:exercise, stub_model(Exercise,
      :body => "MyText",
      :last_import => false
    ).as_new_record)
  end

  it "renders new exercise form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", exercises_path, "post" do
      assert_select "textarea#exercise_body[name=?]", "exercise[body]"
      assert_select "input#exercise_last_import[name=?]", "exercise[last_import]"
    end
  end
end
