require 'spec_helper'

describe "contact_requests/edit" do
  before(:each) do
    @contact_request = assign(:contact_request, stub_model(ContactRequest,
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
    ))
  end

  it "renders the edit contact_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contact_request_path(@contact_request), "post" do
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
