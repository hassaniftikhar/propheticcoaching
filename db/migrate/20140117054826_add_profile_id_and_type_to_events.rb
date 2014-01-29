class AddProfileIdAndTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :profile_id, :string
    add_column :events, :profile_type, :string

    Event.all.each{|e| e.profile_id=e.mentee_id; e.profile_type='mentee';e.save! }

    remove_column :events, :mentee_id
  end
end
