require 'spec_helper'

describe "ebooks/new" do
  before(:each) do
    assign(:ebook, stub_model(Ebook,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new ebook form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ebooks_path, "post" do
      assert_select "input#ebook_name[name=?]", "ebook[name]"
    end
  end
end
