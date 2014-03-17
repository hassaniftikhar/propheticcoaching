class RemoveColumnCoachIdFromMentees < ActiveRecord::Migration
  def change
  		remove_column :mentees, :coach_id
  end
end
