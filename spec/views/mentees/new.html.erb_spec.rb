require 'spec_helper'

describe "mentees/new" do
  before(:each) do
    assign(:mentee, stub_model(Mentee,
      :index => "MyString",
      :show => "MyString"
    ).as_new_record)
  end

  it "renders new mentee form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mentees_path, "post" do
      assert_select "input#mentee_index[name=?]", "mentee[index]"
      assert_select "input#mentee_show[name=?]", "mentee[show]"
    end
  end
end
