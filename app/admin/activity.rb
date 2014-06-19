ActiveAdmin.register Activity do
  
  menu false
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


  batch_action "Assign Category" do |selection|
    activities = Activity.find(selection)
    @selection = selection
    @existing_categories=nil
    render "assign_categories", :locals => {activities: activities, selection: selection}
  end

  collection_action :batch_assign_multiple_categories, :method => [:post] do
    params[:activity_selection].split(",").map(&:to_i).each do |activity_id|
      activity = (Activity.find_by id: activity_id)
      if(params[:checked] == "checked" )
        unless(activity.activity_categorizations.pluck(:category_id).include? params[:category_id].to_i)
          activity.categories << (Category.find_by id: params[:category_id])
        end
      else
        if(activity.activity_categorizations.pluck(:category_id).include? params[:category_id].to_i)
          activity.categories.delete(params[:category_id])
        end
      end
      redirect_to admin_activities_url, flash: {message: "Successfully Assigned Category"}
    end
    # p "==========================================="
    # p params[:activity_selection].split(",").map(&:to_i).first
    # p "==========================================="
    # redirect_to assign_category_admin_activity_path(params[:activity_id])
    # redirect_to assign_category_admin_activity_path(45) 
    # p "==========================================="

    # window.opener.location.href = window.opener.location;
    # activities = Activity.find(29)
    # @selection = params[:activity_selection]
    # @existing_categories=nil
    # # render "assign_categories", :locals => {activities: activities, selection: @selection}
  end

  member_action :assign_category, :method => :get do
    @activity = Activity.find(params[:id])
    # @existing_categories = (Activity.find_by id: params[:activity_id]).categories
    @existing_categories =  @activity.categories
  end

  member_action :assign_multiple_categories, :method => :post do

    existing_categories = (Activity.find_by id: params[:id]).categories
    is_already_category = (Activity.find_by id: params[:id]).activity_categorizations.pluck(:category_id).include? params[:category_id].to_i

    # existing_categories = (Activity.find_by id: params[:activity_id]).categories
    # is_already_category = (Activity.find_by id: params[:activity_id]).activity_categorizations.pluck(:category_id).include? params[:category_id].to_i
    if(params[:checked] == "checked" )
      if(!is_already_category)
        existing_categories << (Category.find_by id: params[:category_id])
      end
    else
      if(is_already_category)
        existing_categories.delete(params[:category_id])
      end
    end
    redirect_to assign_category_admin_activity_path(params[:id])   
  end

  index do
    selectable_column
    column :id
    column :body
    column :category do |activity|
          activity.categories.collect {|category| (category.name)}.join(", ").html_safe
    end
    default_actions
    actions :defaults => false do |activity|
      link_to "Change Category", assign_category_admin_activity_path(activity.id)
    end
  end


end
