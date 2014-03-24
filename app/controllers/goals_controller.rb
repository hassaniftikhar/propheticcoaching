class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]

  # GET /goals
  # GET /goals.json
  # def index
  #   @goals = Goal.all
  # end

  # GET /goals/1
  # GET /goals/1.json
  # def show
    
  # end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  # def edit
  # end

  # POST /goals
  # POST /goals.json
  def send_email
    email = @mentee.email_histories.new
    email.body = @goal.body

    if email.save
      # flash[:notice] = "Email Sent to #{@mentee.first_name} #{@mentee.last_name}"
      # UserMailer.registration_confirmation(@mentee, "New Goal Created", current_user).deliver
      # Resque.enqueue(EmailSend, email.id, @mentee, current_user)
      Resque.enqueue(EmailSend, email.id)
      @msg = "Goal was successfully created and Email Sent to #{@mentee.first_name} #{@mentee.last_name}."
    end
  end
  def create
    @mentee = Mentee.find_by :id => params[:mentee_id]
    @goal = @mentee.goals.new(:body => params[:goal][:body])

    respond_to do |format|
      case params[:commit]
        when 'Send Email' then 
          send_email
        else
          @msg = 'Goal was successfully created.'
      end
      if @goal.save
        # AdminMailer.registration_confirmation(@mentee).deliver

        format.html { redirect_to user_mentee_path(params[:user_id], @mentee), notice: @msg }
        format.json { render action: 'show', status: :created, location: @goal }
      else
        format.html { render action: 'new' }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  # def update
  #   respond_to do |format|
  #     if @goal.update(goal_params)
  #       format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @goal.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /goals/1
  # DELETE /goals/1.json
  # def destroy
  #   @goal.destroy
  #   respond_to do |format|
  #     format.html { redirect_to goals_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal = Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      # params.permit(:mentee_id, :event => [:mentee_id , :id,  :title, :description, :starttime, :endtime,  :all_day, :period, :frequency])

      params.permit(:goal, :commit, :user_id, :mentee_id, :goal => [:body, :id])
      # params.require(:goal).permit(:body)
    end
end
