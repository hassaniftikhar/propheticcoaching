ActiveAdmin.register Mentee do

  controller do
    before_action :set_calendar_properties
    before_action :set_mentee_id

    def permitted_params
      params.permit(:mentees_id_list,  :mentee => [:id, :first_name, :last_name, :email, :date_of_birth, :donor_id, :home_phone,
                                                  :availability, :prophecy, :bc])
    end

    def show
      # @pages = Ebook.last.pages
      # @pages = Page.search params
      @pages = Page.search(params)
      @mentee = Mentee.find_by(id: params[:mentee_id])
    end

    def set_mentee_id
      params[:mentee_id] = params[:id]
    end

    def set_calendar_properties
      gon.editable = current_user.is_admin? ? true : false
      @calendar_editable = gon.editable
    end
  end

  batch_action "Assign Coach" do |selection|
    mentees = Mentee.find(selection)
    @selection = selection
    @existing_coaches=nil
    render "assign_coachs", :locals => {mentees: mentees, selection: selection}
  end

  collection_action :batch_assign_multiple_coaches, :method => :post do


    params[:mentee_selection].split(",").map(&:to_i).each do |mentee_id|
      mentee = (Mentee.find_by id: mentee_id)
      if(params[:checked] == "checked" )
        # unless(mentee.coaches.pluck("id").include? params[:coach_id].to_i)
        unless(mentee.coach_mentee_relations.pluck(:coach_id).include? params[:coach_id].to_i)
          mentee.coaches << (Coach.find_by id: params[:coach_id])
        end
      else
        # if(mentee.coaches.pluck("id").include? params[:coach_id].to_i)
        if(mentee.coach_mentee_relations.pluck(:coach_id).include? params[:coach_id].to_i)
          mentee.coaches.delete(params[:coach_id])
        end
      end
    end
    redirect_to assign_coach_admin_mentee_path(params[:mentee_id])
    # redirect_to root_path
  end

  member_action :assign_coach, :method => :get do
    @mentee = Mentee.find(params[:id])
    @existing_coaches = (Mentee.find_by id: params[:mentee_id]).coaches
  end

  member_action :assign_multiple_coaches, :method => :post do

    existing_coaches = (Mentee.find_by id: params[:mentee_id]).coaches
    # is_already_coach = existing_coaches.pluck("id").include? params[:coach_id].to_i
    is_already_coach = (Mentee.find_by id: params[:mentee_id]).coach_mentee_relations.pluck(:coach_id).include? params[:coach_id].to_i

    if(params[:checked] == "checked" )
      if(!is_already_coach)
        existing_coaches << (Coach.find_by id: params[:coach_id])
        # flash: {message: "Successfully Assigned Coach"}
      end
    else
      if(is_already_coach)
        existing_coaches.delete(params[:coach_id])
        # flash: {message: "Successfully Unassigned Coach"}
      end
    end
    # redirect_to admin_mentees_url, flash: {message: "Successfully Assigned Coach"}
    redirect_to assign_coach_admin_mentee_path(params[:mentee_id])
    
  end


  batch_action "Assign Prophecy" do |selection|
    mentees = Mentee.find(selection)
    render "assign_prophecies", :locals => {mentees: mentees, selection: selection}
  end

  collection_action :assign_multiple_prophecies, :method => :post do
    mentees = Mentee.find(JSON.parse(params[:mentee][:mentees_id_list]))
    mentees.each do |mentee|
      mentee.update_attribute :prophecy, params[:mentee][:prophecy]
    end
    redirect_to admin_mentees_url, flash: {message: "Successfully Assigned Prophecy"}
  end

  collection_action :import_csv, :method => [:get, :post] do
    if request.method == "GET"
      @mentee = Mentee.new
      render "import_csv"
    else
      file = params[:mentee][:csv].tempfile.to_path.to_s
      Mentee.import_csv file
      redirect_to admin_mentees_url, flash: {message: "Successfully Imported CSV"}
    end
  end


  action_item :only => :index do
    link_to('Import Mentee CSV', import_csv_admin_mentees_path)
  end

  action_item :only => :show do
    link_to('Assign/Change Coach', assign_coach_admin_mentee_path(params[:id]))
  end

  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    column :date_of_birth do |mentee|
        if(mentee.date_of_birth)
          "#{mentee.date_of_birth.strftime("%m/%d/%Y")}"
        end
      end
    column :donor_id
    column :home_phone
    column :availability
    column :prophecy do |mentee|
      "#{mentee.prophecy[0..50]} ..." if mentee.prophecy.present?
    end
    column :bc
    column :coach do |mentee|
          mentee.coaches.collect {|coach| (coach.name)}.join(", ").html_safe
    end
    #default_actions
    actions
    actions :defaults => false do |mentee|
      link_to "Change Coach", assign_coach_admin_mentee_path(mentee.id)
    end
  end

  form do |f|
    f.inputs "details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :date_of_birth, order: [:month, :day, :year], :start_year => 1910
      f.input :donor_id
      f.input :home_phone
      f.input :availability
      f.input :prophecy
      f.input :bc
    end
    f.actions
  end

  show do

    span do
      link_to "Back to Mentees List", admin_mentees_path
    end
    br

    button "Search Resources", :id => "btn_ebook_search"
    div :id => "ebook_search", :style => "display:none" do
      render :partial => "admin/ebooks/search"
    end
    button "show calendar", :id => "show_calendar"
    div :id => "calendar", :style => "width:700px;height500px;display:none" do
      render :partial => "/events/actions_dialog", :locals => {:profile => mentee}
    end

    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :date_of_birth do |mentee|
        if(mentee.date_of_birth)
          "#{mentee.date_of_birth.strftime("%m/%d/%Y")}"
        end
      end
      row :donor_id
      row :home_phone
      row :availability
      row :prophecy
      row :bc
      row :coach do |mentee|
          mentee.coaches.collect {|coach| (link_to coach.name, admin_user_path(coach))}.join(", ").html_safe
      end
      if mentee.coaches
        row "Recent Coaches" do |mentee|
          mentee.versions.collect { |version|
            version.reify.coaches.collect { |coach| (link_to coach.name, admin_user_path(coach))} if version.reify && version.reify.coaches
          }.join(", ").html_safe
        end
      end
    end

    # div do
    #   panel "Coaches" do
    #     render :partial => "assign_multi_coachs", :locals => {:profile => mentee}
    #   end      
    # end
    # div do
    #   panel "Goals" do
    #     render :partial => "/goals/show", :locals => {:profile => mentee}
    #     render :partial => "/admin/goals/form"
    #   end      
    # end

    active_admin_comments


  end

end

