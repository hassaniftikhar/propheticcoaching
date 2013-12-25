class AddCoachIdToMentee < ActiveRecord::Migration
  def change
    change_table(:mentees) do |t|
      t.string :coach_id
    end
  end
end
