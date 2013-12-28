ActiveAdmin.register Ebook do

  permit_params :name, :pdf

  #action_item :only => :index do
  #  link_to('Seach All CSV', searches_admin_ebooks_path)
  #end

  collection_action :search, :method => :get do
      @pages = Page.search params
      #respond_to do |format|
        p "=== js call"
      #  format.js { render :partial => 'search' }
      #end
      render :partial => "admin/ebooks/result_table", :locals => {:pages => @pages}
  end

  index do
    column :name
    column :created_at
    column :pdf_file_name
    column :pdf_content_type
    default_actions
  end

  form do |f|
    f.inputs "details" do
      f.input :name
      f.input :pdf, :as => :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :pdf do |file|
        link_to "View PDF", pdf_ebook_path(file)
      end
    end
    active_admin_comments

  end
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

end
