class AddMenteeIdColumnToTasks < ActiveRecord::Migration
  def change
  		add_column :tasks, :mentee_id, :integer
  end
end
