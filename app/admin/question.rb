ActiveAdmin.register Question do

  permit_params :id, :body, :last_import

  scope :All
  scope :LastImported

  collection_action :import_csv, :method => [:get, :post] do
    if request.method == "GET"
      @question = Question.new
      render :partial => "question_import_csv"
    else
      file = params[:question][:csv].tempfile.to_path.to_s
      Question.import_csv file
      @questions = Question.all.where(:last_import => true)
      redirect_to admin_questions_url(:scope => "last_imported"), flash: {message: "Questions Imported Successfully"}
    end
  end

  action_item :only => :index do
    link_to('Import Question CSV', import_csv_admin_questions_path)
  end  
end
