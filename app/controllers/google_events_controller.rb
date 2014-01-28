class GoogleEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:new, :create, :edit]

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
        format.html { render action: 'new' }
        format.json { render json: @google_event.errors, status: :unprocessable_entity }
      end
    end
  end

  #def update
  #end
  #
  #def edit
  #end
  #
  #def destroy
  #end
  #
  #def index
  #end
  #
  #def show
  #end

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