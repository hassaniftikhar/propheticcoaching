class AddProfileIdAndTypeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :profile_id, :string
    add_column :events, :profile_type, :string
    remove_column :events, :mentee_id
  end
end
