ActiveAdmin.register BestFeature do

config.clear_action_items!


   action_item only:[:index] do
     link_to "New Best Feature", new_admin_best_feature_path()
   end

  permit_params :title,:description, :image

  controller do
    def edit
      @page_title = "Edit Best Feature"
    end
  end  

  index :title => 'Best Features' do
    column :title
    column :description
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Details" do
      f.input :title
      f.input :description
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
    panel "Best Feature Details" do
      attributes_table_for best_feature  do
        row :title
        row :description
        row :image do |file|
          link_to "View Image", image_best_feature_path(file)
        end
      end
    end
    active_admin_comments
  end  
end