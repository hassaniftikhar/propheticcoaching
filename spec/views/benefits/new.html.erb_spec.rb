require 'spec_helper'

describe "benefits/new" do
  before(:each) do
    assign(:benefit, stub_model(Benefit,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new benefit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", benefits_path, "post" do
      assert_select "input#benefit_title[name=?]", "benefit[title]"
    end
  end
end
