class DashboardController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_calendar_properties
  # before_action :set_mentee_id  
  def index
    @latest_resources = Ebook.order("created_at desc").limit(5)
    @coach_events 		= @current_user.events.where("endtime >= ? and coach_mentee_relation_id is null", Time.now).order("starttime asc").page(params[:evnt]).per(5) if @current_user.events
    @coach_meetings 	= @current_user.events.where("endtime >= ? and coach_mentee_relation_id is not null", Time.now).order("starttime asc").page(params[:meet]).per(5)
    @user 						= @current_user
    @mentees 					= @user.mentees.page(params[:ment]).per(5)

    p @coach_meetings

  end
end




