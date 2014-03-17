class DashboardController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_calendar_properties
  # before_action :set_mentee_id  
  def index
  		@latest_resources = Ebook.order("created_at desc").limit(5)
  		@coach_events = @current_user.events.where("endtime >= ?", Time.now ).order("starttime asc") if @current_user.events
  		@user    = @current_user
    @mentees = @user.mentees.page params[:page]
  end

end
