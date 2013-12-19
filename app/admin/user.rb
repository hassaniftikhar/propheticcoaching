ActiveAdmin.register User do

  permit_params :first_name, :last_name, :email, :address, :home_phone,
                :availablity_time, :best_time_to_call, :date_of_birth,
                :status, :role_ids => []

  index do
    column :first_name
    column :last_name
    column :email
    column :address
    column :roles
    column :home_phone
    column :availablity_time
    column :status
    column :best_time_to_call
    column :date_of_birth
    column :current_sign_in_at
    column :last_sign_in_at
    #column :current_sign_in_ip
    #column :last_sign_in_ip
    default_actions
  end

  form do |f|
    f.inputs "details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :address
      #f.input :roles, :as => :select, :collection => {"Admin" => :admin, "Coach" => :coach, "Mentee" => :mentee}
      f.input :roles, :as => :check_boxes
      f.input :home_phone
      f.input :availablity_time
      f.input :status, :as => :select, :collection => {"Enable" => true, "Disable" => false}
      f.input :best_time_to_call
      f.input :date_of_birth
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :address
      row :roles
      row :home_phone
      row :availablity_time
      row :best_time_to_call
      row :date_of_birth
    end
    active_admin_comments
  end

end
