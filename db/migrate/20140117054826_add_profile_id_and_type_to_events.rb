class AddProfileIdAndTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :profile_id, :string, :null => false
    add_column :events, :profile_type, :string, :null => false
    remove_column :events, :mentee_id
  end
end
