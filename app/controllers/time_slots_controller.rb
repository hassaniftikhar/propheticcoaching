class TimeSlotsController < ApplicationController
  def new
  		@time_slot = TimeSlot.new
  end

  def create
  	 @coach = User.find_by :id => params[:coach_id]
    @mentee = Mentee.find_by :id => params[:mentee_id]
    @time_slot = @coach.mentees.find_by(:id => params[:mentee_id]).coach_mentee_relations.first.time_slots.new(:time_seconds => params[:time_seconds])
    # @time_slot = @coach.mentees.find_by(:id => 94).coach_mentee_relations.first.time_slots.new(:time_seconds => 180)

    respond_to do |format|
      if @time_slot.save
        # @goal.deliver_email(current_user) if params[:is_send_email]
        format.html { redirect_to user_mentee_path(params[:user_id], @mentee), notice: 'Meeting Time was successfully saved.' }
        format.json { render action: 'show', status: :created, location: @time_slot }
      else
        format.html { render action: 'new' }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end  end
end
