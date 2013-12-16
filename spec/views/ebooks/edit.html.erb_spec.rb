require 'spec_helper'

describe "ebooks/edit" do
  before(:each) do
    @ebook = assign(:ebook, stub_model(Ebook,
      :name => "MyString"
    ))
  end

  it "renders the edit ebook form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ebook_path(@ebook), "post" do
      assert_select "input#ebook_name[name=?]", "ebook[name]"
    end
  end
end
