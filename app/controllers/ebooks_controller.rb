class EbooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ebook_name
  before_action :set_ebook, only: [:show, :edit, :update, :destroy, :pdf]

  # GET /ebooks
  # GET /ebooks.json
  def index
    @ebooks = Ebook.all.order("updated_at desc").page(params[:ebook_page]).per(PER_PAGE_RECORDS)

    @questions = Question.search(params)
    @questions = Kaminari.paginate_array(@questions).page(params[:question_page]).per(PER_PAGE_RECORDS)

    @activities = Activity.search(params)
    @activities = Kaminari.paginate_array(@activities).page(params[:activity_page]).per(PER_PAGE_RECORDS)

    @exercises = Exercise.search(params)
    @exercises = Kaminari.paginate_array(@exercises).page(params[:exercise_page]).per(PER_PAGE_RECORDS)

  end

  # GET /ebooks/1
  # GET /ebooks/1.json
  def show
  end

  # GET /ebooks/1/pdf
  # GET /ebooks/1.json/pdf
  def pdf
    #TODO: this is a security issue as anyone can access the pdf, need to fix so that only jquery can access
    send_file(open(@ebook.pdf.url), :filename => @ebook.pdf.path, :disposition => 'inline', :type => "application/pdf")
  end

  # GET /ebooks/new
  def new
    @ebook = Ebook.new
  end

  # GET /ebooks/1/edit
  def edit
    @ebook = Ebook.find(params[:id])
    @existing_categories =  @ebook.categories  
  end

  # GET /ebooks/search
  def search
    # @pages = Page.search(params)
    # @pages = Kaminari.paginate_array(@pages).page(params[:page]).per(10)
    @pages = Page.search params
  end

  # POST /ebooks
  # POST /ebooks.json
  def create
    @ebook = Ebook.new(ebook_params)
    respond_to do |format|
      if @ebook.save
        format.html { redirect_to @ebook, notice: "#{@ebook_name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @ebook }
      else
        format.html { render action: 'new' }
        format.json { render json: @ebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ebooks/1
  # PATCH/PUT /ebooks/1.json
  def update
    existing_categories = (Ebook.find_by id: params[:id]).categories
    is_already_category = (Ebook.find_by id: params[:id]).ebook_categorizations.pluck(:category_id).include? params[:category_id].to_i

    if(params[:checked] == "checked" )
      if(!is_already_category)
        existing_categories << (Category.find_by id: params[:category_id])
      end
    else
      if(is_already_category)
        existing_categories.delete(params[:category_id])
      end
    end

    respond_to do |format|
      if @ebook.update(ebook_params)
        format.html { redirect_to @ebook, notice: "#{@ebook_name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ebooks/1
  # DELETE /ebooks/1.json
  def destroy
    @ebook.destroy
    respond_to do |format|
      format.html { redirect_to ebooks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ebook
      @ebook = Ebook.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ebook_params
      params.require(:ebook).permit(:name, :pdf, :category_id)
    end

    def set_ebook_name
      @ebook_name = "Resource"
    end
end
