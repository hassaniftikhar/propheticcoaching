class CreateCoachesMenteesJoin < ActiveRecord::Migration
  def change
    #create_table :coaches_mentees_joins do |t|
		  create_table :coaches_mentees_joins, :id => false do |t|
		    t.column :coach_id, :integer
		    t.column :mentee_id, :integer
    end
  end
end