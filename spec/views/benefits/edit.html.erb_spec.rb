require 'spec_helper'

describe "benefits/edit" do
  before(:each) do
    @benefit = assign(:benefit, stub_model(Benefit,
      :title => "MyString"
    ))
  end

  it "renders the edit benefit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", benefit_path(@benefit), "post" do
      assert_select "input#benefit_title[name=?]", "benefit[title]"
    end
  end
end
