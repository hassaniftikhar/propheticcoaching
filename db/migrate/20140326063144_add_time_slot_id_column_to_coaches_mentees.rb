class AddTimeSlotIdColumnToCoachesMentees < ActiveRecord::Migration
  def change
  		add_column :coach_mentee_relations, :id, :primary_key
		
  end
end
