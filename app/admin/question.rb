ActiveAdmin.register Question do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  permit_params :id, :body

  collection_action :import_csv, :method => [:get, :post] do
    if request.method == "GET"
      @question = Question.new
      render :partial => "question_import_csv"
    else
      file = params[:question][:csv].tempfile.to_path.to_s
      Question.import_csv file
      redirect_to admin_questions_url, flash: {message: "successfully imported csv"}
    end
  end

  action_item :only => :index do
    link_to('Import Question CSV', import_csv_admin_questions_path)
  end  
end
