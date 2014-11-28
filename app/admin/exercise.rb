ActiveAdmin.register Exercise do

  menu false
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


  batch_action "Assign Category" do |selection|
    exercises = Exercise.find(selection)
    @selection = selection
    @existing_categories=nil
    render "assign_categories", :locals => {exercises: exercises, selection: selection}
  end

  collection_action :batch_assign_multiple_categories, :method => :post do
    params[:resource_selection].split(",").map(&:to_i).each do |exercise_id|
      exercise = (Exercise.find_by id: exercise_id)
      if(params[:checked] == "checked" )
        unless(exercise.exercise_categorizations.pluck(:category_id).include? params[:category_id].to_i)
          exercise.categories << (Category.find_by id: params[:category_id])
        end
        flash[:notice] = "Successfully Assigned Category"
      else
        if(exercise.exercise_categorizations.pluck(:category_id).include? params[:category_id].to_i)
          exercise.categories.delete(params[:category_id])
        end
        flash[:notice] = "Successfully Unassigned Category"
      end
      exercise.save
      head :no_content
    end
  end

  member_action :assign_category, :method => :get do
    @exercise = Exercise.find(params[:id])
    @existing_categories =  @exercise.categories
  end

  member_action :assign_multiple_categories, :method => :post do

    exercise = (Exercise.find_by id: params[:id])
    existing_categories = (Exercise.find_by id: params[:id]).categories
    is_already_category = (Exercise.find_by id: params[:id]).exercise_categorizations.pluck(:category_id).include? params[:category_id].to_i

    if(params[:checked] == "checked" )
      if(!is_already_category)
        existing_categories << (Category.find_by id: params[:category_id])
      end
    else
      if(is_already_category)
        existing_categories.delete(params[:category_id])
      end
    end
    exercise.save
    redirect_to assign_category_admin_exercise_path(params[:id])   
  end

  index do
    selectable_column
    column :id
    column :body
    column :category do |exercise|
          exercise.categories.order("name asc").collect {|category| (category.name)}.join(", ").html_safe
    end
    actions
    actions :defaults => false do |exercise|
      link_to "Change Category", assign_category_admin_exercise_path(exercise.id)
    end
  end


end