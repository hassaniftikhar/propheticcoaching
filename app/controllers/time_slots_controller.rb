class TimeSlotsController < ApplicationController
  before_action :authenticate_user!
  def new
  		@time_slot = TimeSlot.new
  end

  def create
  	# @coach = User.find_by :id => params[:coach_id]
   #  @mentee = Mentee.find_by :id => params[:mentee_id]
    @event = Event.find_by :id => params[:event_id]
    @time_slot = @event.time_slots.new(:time_seconds => params[:time_seconds])
    # @time_slot = @coach.mentees.find_by(:id => 94).coach_mentee_relations.first.time_slots.new(:time_seconds => 180)
    # p "TimeSlots==================================================="
    # p params

    respond_to do |format|
      if @time_slot.save
        format.html { redirect_to user_mentee_path(params[:coach_id], params[:mentee_id]), notice: 'Session Time was successfully saved.' }
        format.json { render action: 'show', status: :created, location: @time_slot }
      else
        format.html { render action: 'new' }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end  end
end
