class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :mentee_id
      t.text :body

      t.timestamps
    end
  end
end
