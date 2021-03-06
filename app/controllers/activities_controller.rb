class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.search(params)
    # @activities = Kaminari.paginate_array(@activities).page(params[:activity_page]).per(PER_PAGE_RECORDS)
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
    @existing_categories =  @activity.categories  
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update

    existing_categories = (Activity.find_by id: params[:id]).categories
    is_already_category = (Activity.find_by id: params[:id]).activity_categorizations.pluck(:category_id).include? params[:category_id].to_i

    if(params[:checked] == "checked" )
      if(!is_already_category)
        existing_categories << (Category.find_by id: params[:category_id])
      end
    else
      if(is_already_category)
        existing_categories.delete(params[:category_id])
      end
    end
    # redirect_to assign_category_admin_activity_path(params[:id])   

    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:body, :last_import, :category_id)
    end
end
