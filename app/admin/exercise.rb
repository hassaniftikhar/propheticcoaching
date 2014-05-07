ActiveAdmin.register Exercise do

  
  permit_params :id, :body, :last_import

  scope :All
  scope :LastImported

  collection_action :import_csv, :method => [:get, :post] do
    if request.method == "GET"
      @exercise = Exercise.new
      render :partial => "exercise_import_csv"
    else
      file = params[:exercise][:csv].tempfile.to_path.to_s
      Exercise.import_csv file
      @exercises = Exercise.all.order("updated_at desc").where(:last_import => true)
      redirect_to admin_exercises_url(:scope => "last_imported"), flash: {message: "Only New Exercises Imported Successfully"}
    end
  end

  action_item :only => :index do
    link_to('Import Exercise CSV', import_csv_admin_exercises_path)
  end  

end