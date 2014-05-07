ActiveAdmin.register Activity do

  permit_params :id, :body, :last_import

  scope :All
  scope :LastImported

  collection_action :import_csv, :method => [:get, :post] do
    if request.method == "GET"
      @activity = Activity.new
      render :partial => "activity_import_csv"
    else
      file = params[:activity][:csv].tempfile.to_path.to_s
      Activity.import_csv file
      @activities = Activity.all.order("updated_at desc").where(:last_import => true)
      redirect_to admin_activities_url(:scope => "last_imported"), flash: {message: "Only New Activities Imported Successfully"}
    end
  end

  action_item :only => :index do
    link_to('Import Activity CSV', import_csv_admin_activities_path)
  end  
  
end
