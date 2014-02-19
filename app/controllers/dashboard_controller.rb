class DashboardController < ApplicationController
  # before_action :set_calendar_properties
  # before_action :set_mentee_id  
  def index
  		@latest_resources = Ebook.order("created_at desc").limit(5)
  		@coach_events = @current_user.events.where("endtime >= ?", Time.now ).order("starttime asc")
  		@user    = @current_user
    @mentees = @user.mentees.page params[:page]
  end

end
