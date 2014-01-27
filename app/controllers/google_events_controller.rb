class GoogleEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:new, :create, :index, :add_google_calendar]
  

  def new
    @google_calendar = GoogleEvent.new
    render :json => {:form => render_to_string(:partial => 'google_form', , :locals => { :profile => @profile,  )}
    render :partial => "partial", :locals => { :foo => @foo }
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end
end
  def set_profile
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @profile = $1.classify.constantize.find_by id: value
      end
    end
    nil
  end
