require 'spec_helper'

describe "accomplishments/edit" do
  before(:each) do
    @accomplishment = assign(:accomplishment, stub_model(Accomplishment,
      :body => "MyText",
      :mentee_id => 1
    ))
  end

  it "renders the edit accomplishment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", accomplishment_path(@accomplishment), "post" do
      assert_select "textarea#accomplishment_body[name=?]", "accomplishment[body]"
      assert_select "input#accomplishment_mentee_id[name=?]", "accomplishment[mentee_id]"
    end
  end
end
