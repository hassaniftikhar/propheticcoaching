require 'spec_helper'

describe "coaches/edit" do
  before(:each) do
    @coach = assign(:coach, stub_model(Coach,
      :index => "MyString",
      :show => "MyString"
    ))
  end

  it "renders the edit coach form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", coach_path(@coach), "post" do
      assert_select "input#coach_index[name=?]", "coach[index]"
      assert_select "input#coach_show[name=?]", "coach[show]"
    end
  end
end
