require 'spec_helper'

describe "email_histories/new" do
  before(:each) do
    assign(:email_history, stub_model(EmailHistory,
      :body => "MyText",
      :mentee_id => 1
    ).as_new_record)
  end

  it "renders new email_history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", email_histories_path, "post" do
      assert_select "textarea#email_history_body[name=?]", "email_history[body]"
      assert_select "input#email_history_mentee_id[name=?]", "email_history[mentee_id]"
    end
  end
end
