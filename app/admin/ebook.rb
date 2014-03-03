ActiveAdmin.register Ebook do

  menu :label => "Resources"
  # This Clear the default "New ebook" link
  config.clear_action_items!


   action_item only:[:index] do
     link_to "New Resource", new_admin_ebook_path()
   end

  permit_params :name, :pdf

  collection_action :search, :method => :get do
    if params.has_key? "query"
      @pages = Page.search params
      render :partial => "admin/ebooks/result_table", :locals => {:pages => @pages}
    else
      render "admin/ebooks/search"
    end

  end

  action_item :only => :index do
    link_to 'Search Resources', search_admin_ebooks_path
  end
  
  controller do
    def edit
      @page_title = "Edit Resource"
    end
  end  

  index :title => 'Resources' do
    column :name
    column :created_at
    #column :pdf_file_name
    #column :pdf_content_type
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :name
      f.input :pdf, :as => :file
    end
    f.actions
    #f.actions
    # f.actions do
    #   f.action :submit, label: 'Update Resource'
    #   f.action :cancel , label: 'Cancel'
    # end
  #   f.actions do
  #     f.action :submit, :as => :button
  #     f.action :cancel
  #   end
  end
  

  show do
    panel "Resource Details" do
      attributes_table_for ebook  do
        row :name
        row :pdf do |file|
          link_to "View PDF", pdf_ebook_path(file)
        end
      end
    end
    active_admin_comments
  end

  # show do
  #   attributes_table do
  #     row :name
  #     row :pdf do |file|
  #       link_to "View PDF", pdf_ebook_path(file)
  #     end
  #   end
  #   active_admin_comments
  # end


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
