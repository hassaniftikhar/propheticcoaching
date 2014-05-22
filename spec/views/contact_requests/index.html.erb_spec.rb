require 'spec_helper'

describe "contact_requests/index" do
  before(:each) do
    assign(:contact_requests, [
      stub_model(ContactRequest,
        :subject => "Subject",
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :phone_no => "Phone No",
        :contact_mode => "Contact Mode",
        :city => "City",
        :state_country => "State Country",
        :website => "Website",
        :heard_mode => "Heard Mode",
        :purpose => "Purpose",
        :message => "MyText"
      ),
      stub_model(ContactRequest,
        :subject => "Subject",
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :phone_no => "Phone No",
        :contact_mode => "Contact Mode",
        :city => "City",
        :state_country => "State Country",
        :website => "Website",
        :heard_mode => "Heard Mode",
        :purpose => "Purpose",
        :message => "MyText"
      )
    ])
  end

  it "renders a list of contact_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone No".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Mode".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State Country".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => "Heard Mode".to_s, :count => 2
    assert_select "tr>td", :text => "Purpose".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
