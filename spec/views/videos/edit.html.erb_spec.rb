require 'spec_helper'

describe "videos/edit" do
  before(:each) do
    @video = assign(:video, stub_model(Video,
      :title => "MyString",
      :path => "MyString"
    ))
  end

  it "renders the edit video form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", video_path(@video), "post" do
      assert_select "input#video_title[name=?]", "video[title]"
      assert_select "input#video_path[name=?]", "video[path]"
    end
  end
end
