class ChangeChatMessageToText < ActiveRecord::Migration
  def change
    change_column :chats, :message, :text
  end
end
