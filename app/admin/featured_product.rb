ActiveAdmin.register FeaturedProduct do

  
  # menu :label => "Resources"
  # This Clear the default "New ebook" link
  config.clear_action_items!


   action_item only:[:index] do
     link_to "New Featured Product", new_admin_featured_product_path()
   end

  permit_params :title,:description, :price, :image, :profile_type, :profile_id

  controller do
    def edit
      @page_title = "Edit Featured Product"
    end
  end  

  index :title => 'Featured Products' do
    column :title
    column :description
    column :price
    column :profile
    default_actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :title
      f.input :description
      f.input :price
      f.input :profile_id, :label => 'Resource', :as => :select, :collection => Ebook.all.order(:name).map{|resource| ["#{resource.name}", resource.id]}, :include_blank => true
      f.input :profile_type, :as => :hidden, :value => "Ebook"
      f.input :image, :as => :file
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
    panel "Featured Product Details" do
      attributes_table_for featured_product  do
        row :title
        row :description
        row :price
        row :profile
        # row :image do
        #   image_tag(featured_product.image.url)
        # end
        row :image do |file|
          link_to "View Image", image_featured_product_path(file)
        end
      end
    end
    active_admin_comments
  end
  
end