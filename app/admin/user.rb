ActiveAdmin.register User do

  permit_params :first_name, :last_name, :email, :address, :home_phone,
                :availablity_time, :best_time_to_call, :date_of_birth

  index do
    column :first_name
    column :last_name
    column :email
    column :address
    column :roles
    column :home_phone
    column :availablity_time
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
      f.input :roles, :as => :select, :collection => Hash[Role.all.map{|r| [b.name,b.id]}]
      f.input :home_phone
      f.input :availablity_time
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
      row :home_phone
      row :availablity_time
      row :best_time_to_call
      row :date_of_birth
    end
    active_admin_comments
  end

end
