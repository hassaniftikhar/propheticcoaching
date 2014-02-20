class CreateEmailHistories < ActiveRecord::Migration
  def change
    create_table :email_histories do |t|
      t.text :body
      t.integer :mentee_id

      t.timestamps
    end
  end
end
