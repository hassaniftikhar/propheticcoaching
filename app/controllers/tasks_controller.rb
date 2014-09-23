class TasksController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create

    @mentee = Mentee.find_by :id => task_params[:mentee_id]
    @task = @mentee.tasks.new(task_params[:task])
    p "task create============================"
    respond_to do |format|
      if @task.save
        @task.deliver_email(current_user, "New Task Created") if params[:is_send_email]
        format.html { redirect_to user_mentee_path(task_params[:user_id], @mentee), notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    p "task update============================"
    
    @task=Task.find(params[:id])
    respond_to do |format|
     if @task.update_attributes(task_params[:task])
      p "=============== ho gaya update"
      #if @task.update(params)
      format.html { redirect_to  user_mentee_task_path(params[:user_id], @mentee,@task), notice: 'Task was successfully updated.' }
      format.json { head :no_content }
        #format.json { respond_with_bip(params[:user_id], @mentee) }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    # p "task edit============================"
    # p parms
    #@task=Task.find(params[:id])
     p @task
    
  end
  def save

    p @task
   @task=Task.find(params[:task_id])


    respond_to do |format|
     if @task.update_attributes(task_params[:task])
      format.html { redirect_to  user_mentee_path(params[:user_id], @task.mentee), notice: 'Task was successfully updated.' }
      format.json { head :no_content }
        #format.json { respond_with_bip(params[:user_id], @mentee) }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end


  end


  def email_multiple

    @tasks = Task.find(params[:tasks_ids])
    p @tasks
    @tasks.each do |task|
      task.deliver_email(current_user, "New Task Created")
      respond_to do |format|
        format.json { render :json => @tasks}
      end
    end
  end




  # def destroy
  #   @task.destroy
  #   respond_to do |format|
  #     format.html { redirect_to tasks_url }
  #     format.json { head :no_content }
  #   end
  # end

  private

  def task_params
      #params.require(:task).permit(:description, :starttime, :endtime, :status)
      params.permit(:user_id, :mentee_id, :task => [:description, :starttime, :endtime, :status, :id])
    end

    def set_task
      @task = Task.find(params[:id])

    end
  end
