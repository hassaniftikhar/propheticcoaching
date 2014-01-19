require 'spec_helper'

describe "goals/new" do
  before(:each) do
    assign(:goal, stub_model(Goal,
      :body => "MyString"
    ).as_new_record)
  end

  it "renders new goal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", goals_path, "post" do
      assert_select "input#goal_body[name=?]", "goal[body]"
    end
  end
end
