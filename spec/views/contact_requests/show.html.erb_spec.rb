require 'spec_helper'

describe "contact_requests/show" do
  before(:each) do
    @contact_request = assign(:contact_request, stub_model(ContactRequest,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subject/)
    rendered.should match(/First Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
    rendered.should match(/Phone No/)
    rendered.should match(/Contact Mode/)
    rendered.should match(/City/)
    rendered.should match(/State Country/)
    rendered.should match(/Website/)
    rendered.should match(/Heard Mode/)
    rendered.should match(/Purpose/)
    rendered.should match(/MyText/)
  end
end
