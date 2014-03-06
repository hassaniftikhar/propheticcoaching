class TasksController < InheritedResources::Base
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create

    @mentee = Mentee.find_by :id => task_params[:mentee_id]
    @task = @mentee.tasks.new(task_params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_mentee_path(task_params[:user_id], @mentee), notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @task.update(task_params)
  #       format.html { redirect_to @task, notice: 'Task was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @task.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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