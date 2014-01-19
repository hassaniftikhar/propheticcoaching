require 'spec_helper'

describe "mentees/edit" do
  before(:each) do
    @mentee = assign(:mentee, stub_model(Mentee,
      :index => "MyString",
      :show => "MyString"
    ))
  end

  it "renders the edit mentee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mentee_path(@mentee), "post" do
      assert_select "input#mentee_index[name=?]", "mentee[index]"
      assert_select "input#mentee_show[name=?]", "mentee[show]"
    end
  end
end
