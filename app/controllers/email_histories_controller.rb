class EmailHistoriesController < ApplicationController
  before_action :set_email_history, only: [:show, :edit, :update, :destroy]

  # GET /email_histories
  # GET /email_histories.json
  # def index
  #   @email_histories = EmailHistory.all
  # end

  # # GET /email_histories/1
  # # GET /email_histories/1.json
  # def show
  # end

  # GET /email_histories/new
  def new
    @email_history = EmailHistory.new
  end

  # GET /email_histories/1/edit
  # def edit
  # end

  # POST /email_histories
  # POST /email_histories.json
  def create
    @mentee = Mentee.find_by :id => email_history_params[:mentee_id]
    @email_history = @mentee.email_histories.new(email_history_params[:email_history])

    respond_to do |format|
      if @email_history.save
        format.html { redirect_to user_mentee_path(email_history_params[:user_id], @mentee), notice: 'Email History was successfully created.' }
        format.json { render action: 'show', status: :created, location: @email_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @email_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_histories/1
  # PATCH/PUT /email_histories/1.json
  # def update
  #   respond_to do |format|
  #     if @email_history.update(email_history_params)
  #       format.html { redirect_to @email_history, notice: 'Email history was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @email_history.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /email_histories/1
  # # DELETE /email_histories/1.json
  # def destroy
  #   @email_history.destroy
  #   respond_to do |format|
  #     format.html { redirect_to email_histories_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_history
      @email_history = EmailHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_history_params
      params.permit(:user_id, :mentee_id, :email_history => [:body, :id])
    end
end
