ActiveAdmin.register Question do

  menu false
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
      @questions = Question.all.order("updated_at desc").where(:last_import => true)
      redirect_to admin_questions_url(:scope => "last_imported"), flash: {message: "Only New Questions Imported Successfully"}
    end
  end

  action_item :only => :index do
    link_to('Import Question CSV', import_csv_admin_questions_path)
  end  



  batch_action "Assign Category" do |selection|
    questions = Question.find(selection)
    @selection = selection
    @existing_categories=nil
    render "assign_categories", :locals => {questions: questions, selection: selection}
  end

  collection_action :batch_assign_multiple_categories, :method => :post do
    params[:resource_selection].split(",").map(&:to_i).each do |question_id|
      question = (Question.find_by id: question_id)
      if(params[:checked] == "checked" )
        unless(question.question_categorizations.pluck(:category_id).include? params[:category_id].to_i)
          question.categories << (Category.find_by id: params[:category_id])
        end
        flash[:notice] = "Successfully Assigned Category"
      else
        if(question.question_categorizations.pluck(:category_id).include? params[:category_id].to_i)
          question.categories.delete(params[:category_id])
        end
        flash[:notice] = "Successfully Unassigned Category"
      end
      question.save
      head :no_content
    end
  end

  member_action :assign_category, :method => :get do
    @question = Question.find(params[:id])
    @existing_categories =  @question.categories
  end

  member_action :assign_multiple_categories, :method => :post do

    question = (Question.find_by id: params[:id])
    existing_categories = (Question.find_by id: params[:id]).categories
    is_already_category = (Question.find_by id: params[:id]).question_categorizations.pluck(:category_id).include? params[:category_id].to_i

    if(params[:checked] == "checked" )
      if(!is_already_category)
        existing_categories << (Category.find_by id: params[:category_id])
      end
    else
      if(is_already_category)
        existing_categories.delete(params[:category_id])
      end
    end
    question.save
    redirect_to assign_category_admin_question_path(params[:id])   
  end

  index do
    selectable_column
    column :id
    column :body
    column :category do |question|
          question.categories.order("name asc").collect {|category| (category.name)}.join(", ").html_safe
    end
    default_actions
    actions :defaults => false do |question|
      link_to "Change Category", assign_category_admin_question_path(question.id)
    end
  end


end
