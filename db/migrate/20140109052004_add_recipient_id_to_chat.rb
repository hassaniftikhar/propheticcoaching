class AddRecipientIdToChat < ActiveRecord::Migration
  def change
    change_table(:chats) do |t|
      t.integer :recipient_id
    end
  end
end