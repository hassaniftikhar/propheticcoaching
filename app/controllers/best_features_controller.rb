class BestFeaturesController < ApplicationController
  before_action :set_best_feature, only: [:show, :edit, :update, :destroy]

  # GET /best_features
  # GET /best_features.json
  def index
    @best_features = BestFeature.all
  end

  # GET /best_features/1
  # GET /best_features/1.json
  def show
  end

  # GET /best_features/new
  def new
    @best_feature = BestFeature.new
  end

  # GET /best_features/1/edit
  def edit
  end

  def image
    #TODO: this is a security issue as anyone can access the pdf, need to fix so that only jquery can access
    @best_feature = BestFeature.find_by(id: params[:id])
    send_file(open(@best_feature.image.url), :filename => @best_feature.image.path, :disposition => 'inline', :type => "image/jpeg")
  end

  # POST /best_features
  # POST /best_features.json
  def create
    @best_feature = BestFeature.new(best_feature_params)

    respond_to do |format|
      if @best_feature.save
        format.html { redirect_to @best_feature, notice: 'Best feature was successfully created.' }
        format.json { render action: 'show', status: :created, location: @best_feature }
      else
        format.html { render action: 'new' }
        format.json { render json: @best_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /best_features/1
  # PATCH/PUT /best_features/1.json
  def update
    respond_to do |format|
      if @best_feature.update(best_feature_params)
        format.html { redirect_to @best_feature, notice: 'Best feature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @best_feature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /best_features/1
  # DELETE /best_features/1.json
  def destroy
    @best_feature.destroy
    respond_to do |format|
      format.html { redirect_to best_features_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_best_feature
      @best_feature = BestFeature.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def best_feature_params
      params.require(:best_feature).permit(:title, :description, :image)
    end
end
