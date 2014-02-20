require 'spec_helper'

describe "email_histories/show" do
  before(:each) do
    @email_history = assign(:email_history, stub_model(EmailHistory,
      :body => "MyText",
      :mentee_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
