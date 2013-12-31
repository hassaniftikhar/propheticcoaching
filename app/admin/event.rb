ActiveAdmin.register Event do

  permit_params :title, :description, :starttime, :endtime, :mentee_id

  index do
    column :title
    column :description
    column :starttime
    column :endtime
    column :mentee

    default_actions
  end


  #form do |f|

    #render :partial => "/events/form"
    #f.semantic_errors *f.object.errors.keys
    #f.inputs "Details" do
    #  f.input :title
    #  f.input :description
    #  f.input :starttime
    #  f.input :endtime
    #  f.input :mentee
    #end
    #f.actions
  #end

  show do |user|
    span do
      link_to "Back to Events List", admin_events_path
    end
    attributes_table do
      row :title
      row :description
      row :starttime
      row :endtime
      row :mentee
    end
    active_admin_comments
  end

end
