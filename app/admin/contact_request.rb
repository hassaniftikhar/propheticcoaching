ActiveAdmin.register ContactRequest do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  config.clear_action_items!

  permit_params :subject, :first_name, :last_name, :email, :phone_no, :contact_mode, :city, :state_country, :website, :heard_mode, :purpose, :message
end
