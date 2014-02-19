class AddDateOfBirthColumnToMentee < ActiveRecord::Migration
  def change
  		add_column :mentees, :date_of_birth, :date
  end
end
