require 'spec_helper'

describe "goals/edit" do
  before(:each) do
    @goal = assign(:goal, stub_model(Goal,
      :body => "MyString"
    ))
  end

  it "renders the edit goal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", goal_path(@goal), "post" do
      assert_select "input#goal_body[name=?]", "goal[body]"
    end
  end
end
