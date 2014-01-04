require 'spec_helper'

describe "chats/edit" do
  before(:each) do
    @chat = assign(:chat, stub_model(Chat,
      :new => "MyString",
      :create => "MyString",
      :update => "MyString",
      :edit => "MyString",
      :destroy => "MyString",
      :index => "MyString",
      :show => "MyString"
    ))
  end

  it "renders the edit chat form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", chat_path(@chat), "post" do
      assert_select "input#chat_new[name=?]", "chat[new]"
      assert_select "input#chat_create[name=?]", "chat[create]"
      assert_select "input#chat_update[name=?]", "chat[update]"
      assert_select "input#chat_edit[name=?]", "chat[edit]"
      assert_select "input#chat_destroy[name=?]", "chat[destroy]"
      assert_select "input#chat_index[name=?]", "chat[index]"
      assert_select "input#chat_show[name=?]", "chat[show]"
    end
  end
end
