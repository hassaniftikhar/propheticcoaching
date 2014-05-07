class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.text :body
      t.boolean :last_import

      t.timestamps
    end
  end
end
