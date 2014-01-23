class EventsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_calendar_properties
  before_action :set_profile, only: [:new, :create, :index]

  def set_calendar_properties
    gon.editable = current_user.is_admin? ? true : false
    @calendar_editable = gon.editable
    p "=== @calendar_editable: #{@calendar_editable}"
  end

  def new
    p "===== params: #{event_params.inspect}"
    #if event_params[:mentee_id].present?
    #  @profile = Mentee.find_by id: event_params[:mentee_id]
    #else
    #  @profile = User.find_by id: event_params[:user_id]
    #end
    @event = Event.new(:endtime => 1.hour.from_now, :period => "Does not repeat")
    render :json => {:form => render_to_string(:partial => 'form')}
  end

  def create
    #@mentee = Mentee.where("id = #{event_params[:mentee_id]}").first
    if params[:event][:period] == "Does not repeat"
      event = @profile.events.new event_params[:event]
    else
      event = EventSeries.new(event_params[:event])
    end
    if event.save
      render :nothing => true
    else
      render :text => event.errors.full_messages.to_sentence, :status => 422
    end
  end

  def index
    #@mentee = Mentee.find_by :id => params[:mentee_id]
  end

  #TODO fix get events
  def get_events
    if params[:mentee_id].present?
      profile = Mentee.find_by id: params[:mentee_id]
    elsif params[:coach_id].present?
      profile = User.coach.find_by id: params[:coach_id]
    end
    if profile
      @events = profile.events.where "starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' AND endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"
    else
      @events = Event.where "starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' AND endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}' AND profile_type = 'User'"
    end

    events = []
    @events.each do |event|
      events << {:id => event.id, :title => event.title, :description => event.description || "Some cool description here...", :start => "#{event.starttime.iso8601}", :end => "#{event.endtime.iso8601}", :allDay => event.all_day, :recurring => (event.event_series_id) ? true : false}
    end
    render :text => events.to_json
  end

  def move
    @event = Event.find_by_id params[:id]
    if @event
      @event.starttime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.starttime))
      @event.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
      @event.all_day = params[:all_day]
      @event.save
    end
    render :nothing => true
  end

  def resize
    @event = Event.find_by_id params[:id]
    if @event
      @event.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
      @event.save
    end
    render :nothing => true
  end

  def edit
    @event = Event.find_by_id(params[:id])
    render :json => {:form => render_to_string(:partial => 'form')}
  end

  def update
    @event = Event.find_by_id(params[:event][:id])
    if params[:event][:commit_button] == "Update All Occurrence"
      @events = @event.event_series.events #.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.update_events(@events, event_params[:event])
    elsif params[:event][:commit_button] == "Update All Following Occurrence"
      @events = @event.event_series.events.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.update_events(@events, event_params[:event])
    else
      @event.update(event_params[:event])
    end
    render :nothing => true
  end

  def destroy
    @event = Event.find_by_id(params[:id])
    if params[:delete_all] == 'true'
      @event.event_series.destroy
    elsif params[:delete_all] == 'future'
      @events = @event.event_series.events.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.event_series.events.delete(@events)
    else
      @event.destroy
    end
    render :nothing => true
  end

  private
  def event_params
    params.permit(:mentee_id, :user_id, :event => [:mentee_id, :id, :title, :description, :starttime, :endtime, :all_day, :period, :frequency])
  end


  def set_profile
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @profile = $1.classify.constantize.find_by id: value
      end
    end
    nil
  end

end
