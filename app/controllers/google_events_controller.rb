class GoogleEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:new, :create, :edit, :update, :index]
  before_action :set_google_event, only: [:show, :edit, :update, :destroy]

  def new
    @google_event = @profile.google_events.new
    render :json => {:form => render_to_string(:partial => 'form')}
  end

  def create
    @google_event = @profile.google_events.new google_event_params
    respond_to do |format|
      if @google_event.save
        format.html { redirect_to request.referer, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @google_event }
      else
        format.html { render :text => @google_event.errors.full_messages.to_sentence, :status => 422 }
        format.json { render json: @google_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @google_event.update(google_event_params)
        format.html { redirect_to request.referer, notice: 'Event was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @google_event }
      else
        format.html { render :text => @google_event.errors.full_messages.to_sentence, :status => 422 }
        format.json { render json: @google_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    render :json => {:form => render_to_string(:partial => 'form')}
  end

  def destroy
    google_event = GoogleEvent.find_by_id(params[:id])
    google_event.destroy
    respond_to do |format|
      if @google_event.profile_type == "User"
        format.html { redirect_to user_google_events_url }
      else
        format.html { redirect_to mentee_google_events_url }
      end
      format.json { head :no_content }
    end
  end

  def index
    @google_events = @profile.google_events.page params[:page]
  end

  def show
  end

  private

  def google_event_params
    params.require(:google_event).permit(:url, :google_calendar_api_key, :google_calendar_id)
  end

  def set_google_event
    @google_event = GoogleEvent.find_by id: params[:id]
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