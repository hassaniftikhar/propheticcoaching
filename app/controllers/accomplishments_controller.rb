class AccomplishmentsController < ApplicationController
  before_action :set_accomplishment, only: [:show, :edit, :update, :destroy]

  # GET /accomplishments
  # GET /accomplishments.json
  # def index
  #   @accomplishments = Accomplishment.all
  # end

  # # GET /accomplishments/1
  # # GET /accomplishments/1.json
  # def show
  # end

  # GET /accomplishments/new
  def new
    @accomplishment = Accomplishment.new
  end

  # # GET /accomplishments/1/edit
  # def edit
  # end

  # POST /accomplishments
  # POST /accomplishments.json
  def create

    @mentee = Mentee.find_by :id => accomplishment_params[:mentee_id]
    @accomplishment = @mentee.accomplishments.new(accomplishment_params[:accomplishment])

    respond_to do |format|
      if @accomplishment.save
        format.html { redirect_to user_mentee_path(accomplishment_params[:user_id], @mentee), notice: 'Accomplishment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @accomplishment }
      else
        format.html { render action: 'new' }
        format.json { render json: @accomplishment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accomplishments/1
  # PATCH/PUT /accomplishments/1.json
  # def update
  #   respond_to do |format|
  #     if @accomplishment.update(accomplishment_params)
  #       format.html { redirect_to @accomplishment, notice: 'Accomplishment was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @accomplishment.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /accomplishments/1
  # # DELETE /accomplishments/1.json
  # def destroy
  #   @accomplishment.destroy
  #   respond_to do |format|
  #     format.html { redirect_to accomplishments_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accomplishment
      @accomplishment = Accomplishment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accomplishment_params
      params.require(:accomplishment).permit(:body, :mentee_id)
      params.permit(:user_id, :mentee_id, :accomplishment => [:body, :id])
    end
end
