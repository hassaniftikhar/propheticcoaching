ActiveAdmin.register Ebook do

  menu :label => "Ebooks"
  menu false
  # This Clear the default "New ebook" link
  config.clear_action_items!


   action_item only:[:index] do
     link_to "New Resource", new_admin_ebook_path()
   end

  permit_params :name, :pdf

  collection_action :search, :method => :get do
    if params.has_key? "query"
      # @pages = Page.search params
      @pages = Page.search(params)
      # @pages = Kaminari.paginate_array(@pages).page(params[:ebook_search_page]).per(10)
      p "admin ser====================================="
      # p @pages
      render :partial => "admin/ebooks/result_table", :locals => {:pages => @pages}
    else
      p "else admin ser====================================="
      @pages = Page.search(params)
      # @pages = Kaminari.paginate_array(@pages).page(params[:ebook_search_page]).per(10)
      paginated_collection(Kaminari.paginate_array(@pages).page(params[:ebook_search_page]).per(10), param_name: 'ebook_search_page') do
       table_for(collection) do |cr|
        column(I18n.t("cr.ebook_id")) { |cr| I18n.l cr.ebook_id, format: :raw }
          #other columns...
       end
      end

      # @pages = Kaminari.paginate_array(@pages).page(params[:ebook_search_page]).per(10)
      # render "admin/ebooks/search"
      # render :partial => "admin/ebooks/result_table", :locals => {:pages => @pages}
      # p @pages
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


  batch_action "Assign Category" do |selection|
    ebooks = Ebook.find(selection)
    @selection = selection
    @existing_categories=nil
    render "assign_categories", :locals => {ebooks: ebooks, selection: selection}
  end

  collection_action :batch_assign_multiple_categories, :method => :post do

    # p "======================================="
    # p params[:resource_selection]
    # p "======================================="
    
    params[:resource_selection].split(",").map(&:to_i).each do |ebook_id|
      ebook = (Ebook.find_by id: ebook_id)
      if(params[:checked] == "checked" )
        unless(ebook.ebook_categorizations.pluck(:category_id).include? params[:category_id].to_i)
          ebook.categories << (Category.find_by id: params[:category_id])
        end
        flash[:notice] = "Successfully Assigned Category"
      else
        if(ebook.ebook_categorizations.pluck(:category_id).include? params[:category_id].to_i)
          ebook.categories.delete(params[:category_id])
        end
        flash[:notice] = "Successfully Unassigned Category"
      end
    end
    head :no_content
    # p params
    # p "red ==================================================="
    # redirect_to assign_category_admin_ebook_path(params[:ebook_id])
  end

  member_action :assign_category, :method => :get do
    @ebook = Ebook.find(params[:id])
    @existing_categories =  @ebook.categories
  end

  member_action :assign_multiple_categories, :method => :post do

    existing_categories = (Ebook.find_by id: params[:id]).categories
    is_already_category = (Ebook.find_by id: params[:id]).ebook_categorizations.pluck(:category_id).include? params[:category_id].to_i

    if(params[:checked] == "checked" )
      if(!is_already_category)
        existing_categories << (Category.find_by id: params[:category_id])
      end
    else
      if(is_already_category)
        existing_categories.delete(params[:category_id])
      end
    end
    redirect_to assign_category_admin_ebook_path(params[:id])   
  end

  index :title => 'Resources' do
    selectable_column
    column :id
    column :name
    column :created_at
    column :category do |ebook|
          ebook.categories.collect {|category| (category.name)}.join(", ").html_safe
    end
    default_actions
    actions :defaults => false do |ebook|
      link_to "Change Category", assign_category_admin_ebook_path(ebook.id)
    end
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
