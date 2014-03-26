class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer		:time_seconds
  				t.integer		:coach_mentee_relation_id

      t.timestamps
    end
  end
end
