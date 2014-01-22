class MenteesController < ApplicationController
  before_action :set_mentee, only: [:show, :edit, :update, :destroy]

  # GET /mentees
  # GET /mentees.json
  def index
    @user    = User.find_by id: params[:user_id]
    @mentees = @user.mentees.page params[:page]

  end

  # GET /mentees/1
  # GET /mentees/1.json
  def show
    
  end

  # GET /mentees/new
  def new
    @mentee = Mentee.new
  end

  # GET /mentees/1/edit
  def edit
  end

  # POST /mentees
  # POST /mentees.json
  def create
    @mentee = Mentee.new(mentee_params)

    respond_to do |format|
      if @mentee.save
        format.html { redirect_to @mentee, notice: 'Mentee was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mentee }
      else
        format.html { render action: 'new' }
        format.json { render json: @mentee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mentees/1
  # PATCH/PUT /mentees/1.json
  def update
    respond_to do |format|
      if @mentee.update(mentee_params)
        format.html { redirect_to @mentee, notice: 'Mentee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mentee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentees/1
  # DELETE /mentees/1.json
  def destroy
    @mentee.destroy
    respond_to do |format|
      format.html { redirect_to mentees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mentee
      @mentee = Mentee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mentee_params
      params.require(:mentee).permit(:index, :show)
    end
end
