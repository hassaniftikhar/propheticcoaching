ActiveAdmin.register User do
  #
  #permit_params :first_name, :last_name, :email, :address, :home_phone,
  #              :availablity_time, :best_time_to_call, :date_of_birth,
  #              :status, :role_ids => []
  #actions :all, :except => [:new]

  collection_action :import_csv, :method => [:get, :post] do
    if request.method == "GET"
      @user = User.new
      render :partial => "import_csv"
    else
      file = params[:user][:csv].tempfile.to_path.to_s
      User.import_csv file
      redirect_to admin_users_url, flash: {message: "successfully imported csv"}
    end
  end
  
  controller do
    def permitted_params
      params.permit!
      #params.permit(:user => [:first_name, :last_name, :email, :address, :home_phone,
      # :availablity_time, :best_time_to_call, :date_of_birth,
      # :status, :role_ids => []])
    end
  end

  action_item :only => :index do
    link_to('Import User CSV', import_csv_admin_users_path)
  end

  index do
    column :first_name
    column :last_name
    column :email
    column :address
    column :roles do |user|
      "#{user.roles_name.join(', ')}"
    end
    column :home_phone
    column :availablity_time
    #column :status do |user|
    #  user.status? ? "Enabled" : "Disabled"
    #end
    column :best_time_to_call
    column :date_of_birth
    #column :current_sign_in_at
    #column :last_sign_in_at
    #column :current_sign_in_ip
    #column :last_sign_in_ip
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :address
      f.input :roles, :as => :check_boxes
      f.input :home_phone
      f.input :availablity_time, :as => :select, :collection => {"Morning" => "morning", "Afternoon" => "afternoon", "Evening" => "evening"}
      #f.input :status, :as => :select, :collection => {"Enable" => true, "Disable" => false}
      f.input :best_time_to_call
      f.input :date_of_birth, :start_year => Time.now.year - 70
    end
    f.actions
  end

  show do |user|
    #@user = params[:id]
    @user = user
    button "show calendar", :id => "show_calendar"
    div :id => "calendar", :style => "width:700px;height500px;display:none", :user_id => @user do
      render :partial => "/events/actions_dialog", :locals => {:user => @user }
    end

    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :address
      row :roles do |user|
        "#{user.roles_name.join(', ')}"
      end
      row :home_phone
      row :availablity_time
      row :best_time_to_call
      row :date_of_birth
      row :mentees do |user|
        user.mentees.collect { |r| link_to(r.name, admin_mentee_path(r.id)) }.join(", ").html_safe
      end
    end
    active_admin_comments
  end

end
