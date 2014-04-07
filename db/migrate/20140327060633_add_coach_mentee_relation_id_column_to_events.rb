class AddCoachMenteeRelationIdColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :coach_mentee_relation_id, :integer
  end
end
