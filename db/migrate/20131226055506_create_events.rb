class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :starttime, :endtime
      t.boolean :all_day, :default => false
      t.integer :event_series_id
      t.integer :mentee_id
      t.timestamps
    end
  end
end
