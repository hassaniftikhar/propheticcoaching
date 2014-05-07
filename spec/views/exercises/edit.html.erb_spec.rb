require 'spec_helper'

describe "exercises/edit" do
  before(:each) do
    @exercise = assign(:exercise, stub_model(Exercise,
      :body => "MyText",
      :last_import => false
    ))
  end

  it "renders the edit exercise form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", exercise_path(@exercise), "post" do
      assert_select "textarea#exercise_body[name=?]", "exercise[body]"
      assert_select "input#exercise_last_import[name=?]", "exercise[last_import]"
    end
  end
end
