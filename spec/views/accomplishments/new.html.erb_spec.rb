require 'spec_helper'

describe "accomplishments/new" do
  before(:each) do
    assign(:accomplishment, stub_model(Accomplishment,
      :body => "MyText",
      :mentee_id => 1
    ).as_new_record)
  end

  it "renders new accomplishment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accomplishments_path, "post" do
      assert_select "textarea#accomplishment_body[name=?]", "accomplishment[body]"
      assert_select "input#accomplishment_mentee_id[name=?]", "accomplishment[mentee_id]"
    end
  end
end
