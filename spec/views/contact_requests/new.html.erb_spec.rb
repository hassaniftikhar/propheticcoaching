require 'spec_helper'

describe "contact_requests/new" do
  before(:each) do
    assign(:contact_request, stub_model(ContactRequest,
      :subject => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :phone_no => "MyString",
      :contact_mode => "MyString",
      :city => "MyString",
      :state_country => "MyString",
      :website => "MyString",
      :heard_mode => "MyString",
      :purpose => "MyString",
      :message => "MyText"
    ).as_new_record)
  end

  it "renders new contact_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contact_requests_path, "post" do
      assert_select "input#contact_request_subject[name=?]", "contact_request[subject]"
      assert_select "input#contact_request_first_name[name=?]", "contact_request[first_name]"
      assert_select "input#contact_request_last_name[name=?]", "contact_request[last_name]"
      assert_select "input#contact_request_email[name=?]", "contact_request[email]"
      assert_select "input#contact_request_phone_no[name=?]", "contact_request[phone_no]"
      assert_select "input#contact_request_contact_mode[name=?]", "contact_request[contact_mode]"
      assert_select "input#contact_request_city[name=?]", "contact_request[city]"
      assert_select "input#contact_request_state_country[name=?]", "contact_request[state_country]"
      assert_select "input#contact_request_website[name=?]", "contact_request[website]"
      assert_select "input#contact_request_heard_mode[name=?]", "contact_request[heard_mode]"
      assert_select "input#contact_request_purpose[name=?]", "contact_request[purpose]"
      assert_select "textarea#contact_request_message[name=?]", "contact_request[message]"
    end
  end
end
