class ChangeCoachMenteeRelationIdColumnInTimeSlots < ActiveRecord::Migration
  def change
  		remove_column :time_slots, :coach_mentee_relation_id
  		add_column :time_slots, :event_id, :integer
  end
end
