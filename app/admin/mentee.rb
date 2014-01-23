ActiveAdmin.register Mentee do

  controller do
    before_action :set_calendar_properties
    before_action :set_mentee_id

    def permitted_params
      params.permit(:mentees_id_list, :mentee => [:first_name, :last_name, :email, :donor_id, :home_phone,
                                                  :availability, :prophecy, :bc, :coach_id, :mentees_id_list])
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
    render "assign_coachs", :locals => {mentees: mentees, selection: selection}
  end

  collection_action :assign_multiple_coaches, :method => :post do
    mentees = Mentee.find(JSON.parse(params[:mentee][:mentees_id_list]))
    mentees.each do |mentee|
      mentee.update_attribute :coach_id, params[:mentee][:coach_id]
    end
    redirect_to admin_mentees_url, flash: {message: "Successfully Assigned Coach"}
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

  member_action :assign_coach, :method => :get do
    @mentee = Mentee.find(params[:id])
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
      render "/events/actions_dialog", :locals => {:profile_id => params[:id], :profile_type => self.class.to_s}
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

      if mentee.coach
        row "Recent Coaches" do |mentee|
          mentee.versions.collect { |version|
            (link_to version.reify.coach.name, admin_user_path(version.reify.coach)) if version.reify && version.reify.coach
          }.join(", ").html_safe
        end
      end
    end

    active_admin_comments


  end

end

