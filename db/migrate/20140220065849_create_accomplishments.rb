class CreateAccomplishments < ActiveRecord::Migration
  def change
    create_table :accomplishments do |t|
      t.text :body
      t.integer :mentee_id

      t.timestamps
    end
  end
end
