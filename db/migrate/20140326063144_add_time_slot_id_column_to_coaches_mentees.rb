class AddTimeSlotIdColumnToCoachesMentees < ActiveRecord::Migration
  def change
  		add_column :coaches_mentees_joins, :id, :primary_key
		
  end
end
