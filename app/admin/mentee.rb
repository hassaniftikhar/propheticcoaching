ActiveAdmin.register Mentee do

  permit_params :first_name, :last_name, :email, :donor_id, :home_phone,
                :availability, :prophecy, :bc, :coach_id

  #action_item :all, :except => [:new]

  collection_action :import_csv, :method => [:get, :post] do
    if request.method == "GET"
      @mentee = Mentee.new
      render :partial => "import_csv"
    else
      file = params[:mentee][:csv].tempfile.to_path.to_s
      Mentee.import_csv file
      redirect_to admin_mentees_url, flash: {message: "successfully imported csv"}
    end
  end

  member_action :assign_coach, :method => :get do
    @mentee = Mentee.find(params[:id])
    #user.lock!
    #redirect_to {:action => :show}, {:notice => "Locked!"}
  end

  controller do
    before_action :set_calendar_properties
    before_action :set_mentee_id

    def set_mentee_id
      params[:mentee_id] = params[:id]
    end

    def set_calendar_properties
      gon.editable = current_user.is_admin? ? true : false
      @calendar_editable = gon.editable
    end
  end

  action_item :only => :index do
    link_to('Import Mentee CSV', import_csv_admin_mentees_path)
  end

  action_item :only => :show do
    link_to('Assign/Change Coach', assign_coach_admin_mentee_path(params[:id]))
  end

  index do
    column :first_name
    column :last_name
    column :email
    column :donor_id
    column :home_phone
    column :availability
    column :prophecy do |mentee|
      "#{mentee.prophecy[0..50]} ..." if mentee.prophecy.present?
    end
    column :bc
    column :coach do |mentee|
      mentee.coach.name if mentee.coach
    end

    default_actions
    actions :defaults => false do |mentee|
      link_to "Change Coach", assign_coach_admin_mentee_path(mentee.id)
    end
  end

  form do |f|
    f.inputs "details" do
      f.input :first_name
      f.input :last_name
      f.input :email
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
    button "Search Ebooks", :id => "btn_ebook_search"
    div :id => "ebook_search", :style => "display:none" do
      render :partial => "admin/ebooks/search"
    end
    button "show calendar", :id => "show_calendar"
    div :id => "calendar", :style => "width:700px;height500px;display:none", :mentee_id => params[:id] do
      render "/events/actions_dialog"
    end

    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :donor_id
      row :home_phone
      row :availability
      row :prophecy
      row :bc
      row :coach do |mentee|
        link_to(mentee.coach.name, admin_user_path(mentee.coach)) if mentee.coach
      end
    end

    active_admin_comments



  end

end
