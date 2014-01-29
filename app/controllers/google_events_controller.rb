class GoogleEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:new, :create, :edit, :index]

  def new
    @google_event = @profile.google_events.new
    render :json => {:form => render_to_string(:partial => 'form')}
  end

  def create
    @google_event = @profile.google_events.new google_event_params[:google_event]
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
    @google_event = GoogleEvent.find_by_id(params[:id])
    #render :json => {:form => render_to_string(:partial => 'form', locals => )}
    render :json => {:form => render_to_string(:partial => 'form')}

  end
  
  def destroy
    google_event = GoogleEvent.find_by_id(params[:id])
    google_event.destroy
    #render :nothing => true
    respond_to do |format|
      format.html { redirect_to user_google_events_url }
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
    params.permit(:google_event => [:url])
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