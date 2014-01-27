class CreateGoogleEvents < ActiveRecord::Migration
  def change
    create_table :google_events do |t|
      t.string :url
      t.integer :profile_id
      t.string :profile_type

      t.timestamps
    end
  end
end
