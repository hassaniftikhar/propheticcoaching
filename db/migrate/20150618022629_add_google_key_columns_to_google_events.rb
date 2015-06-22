class AddGoogleKeyColumnsToGoogleEvents < ActiveRecord::Migration
  def change
  	add_column :google_events, :google_calendar_api_key, :string
  	add_column :google_events, :google_calendar_id, :string
  end
end
