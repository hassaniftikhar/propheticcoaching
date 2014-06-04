ActiveAdmin.register Event do
  config.clear_action_items!
  config.sort_order = "id_desc"
  # actions :all, :except => [:new]

  scope :GenericEvents, :default => true
  scope :Sessions, :default => true
  
  action_item :only => :index do
    link_to 'New Session', new_admin_event_path(:meeting => true)
  end  
  controller do
    def permitted_params
      # params.permit(:event, :coach_id, :mentee_id, :meeting, :title, :description, :starttime, :endtime, :profile, :all_day, :period, :frequency, :id, :profile_id, :profile_type, :coach_mentee_relation_id)
      # params.require(:event).permit(:coach_id, :mentee_id, :meeting, :title, :description, :starttime, :endtime, :profile, :all_day, :period, :frequency, :id, :profile_id, :profile_type, :coach_mentee_relation_id, :event)
      # params.permit(:coach_id, :mentee_id, :meeting, :title, :description, :starttime, :endtime, :profile, :all_day, :period, :frequency, :id, :profile_id, :profile_type, :coach_mentee_relation_id, :event)
      params.permit!
    end
    # def resource
    #   # Event.where(id: params[:id]).first!
    #   Event.all.where('coach_mentee_relation_id IS NOT NULL')
    #   # p "event==============================================="
    # end
    # def scoped_collection
    #   # Post.includes(:author)
    #   Event.all.where('coach_mentee_relation_id IS NOT NULL')
    #   # p "event==============================================="
    # end
    # def build_resource_params
    #   [params.fetch(:event, {}).permit(:coach_id, :mentee_id, :meeting, :title, :description, :starttime, :endtime, :profile, :all_day, :period, :frequency, :id, :profile_id, :profile_type, :coach_mentee_relation_id, :event)]
    # end

    def set_coach_mentee_relation_id(user)
      params[:event][:coach_mentee_relation_id] = user.coach_mentee_relations.find_by(mentee_id: params[:event][:mentee_id]).id
      @coach_mentee_relation_id = user.coach_mentee_relations.find_by(mentee_id: params[:event][:mentee_id]).id
      params[:event].delete :coach_id
      params[:event].delete :mentee_id
    end

    def create
      if user = (User.find_by id: params[:event][:coach_id])
        set_coach_mentee_relation_id(user)
        if params[:event][:period] == "Does not repeat"
          @event = Event.new(permitted_params[:event])
          super
        else
          params[:event].delete :coach_mentee_relation_id
          @event = EventSeries.new(permitted_params[:event])
          @event.profile = @profile || current_user
          @event.coach_mentee_relation_id = @coach_mentee_relation_id || nil
          super do |format|
            redirect_to admin_event_path(@event.events.last) and return if resource.valid?
          end
        end
      end
      # super
      # super do |format|
      #   redirect_to admin_event_path(@event.events.last) and return if resource.valid?
      # end
    end    

    def update(options={}, &block)
      if user = (User.find_by id: params[:event][:coach_id])
        @event = Event.find(params[:event][:id])
        set_coach_mentee_relation_id(user)
      end

      super do |success, failure|
        block.call(success, failure) if block
        failure.html { render :edit }
      end
    end

  end
  index do
    selectable_column
    column :title
    column :description
    column :starttime
    column :endtime
    column :profile


    default_actions
  end

  # index :as => :grid, :default => true do |event|
  #   link_to(event.title, admin_event_path(event))
  # end
  @event = Event.new(:period => "Does not repeat")
  form :partial => "form"

  # form do |f|

  #   # render :partial => "/admin/events/form"
  #   f.semantic_errors *f.object.errors.keys
  #   f.inputs "Details" do
  #    f.input :title
  #    f.input :description
  #    f.input :starttime
  #    f.input :endtime
  #    # f.select("Mentee", "mentee_id", Mentee.all.collect {|mentee| [ mentee.first_name, mentee.id ] }, { :include_blank => false, :selected => params[:mentee_id] })
  #    # f.select(:description, Mentee.all.collect {|mentee| [ mentee.first_name, mentee.id ] })
  #    # f.input :coach_mentee_relation_id, :label => 'CoachMenteeList', :as => :select, :collection => Mentee.all.order(:id).collect {|mentee| [ mentee.id, mentee.first_name ] }, :include_blank => true
  #    f.input :coach_mentee_relation_id, :label => 'Coach Mentee List', :as => :select, :collection => CoachMenteeRelation.all.order(:coach_id).collect {|relation| [ "#{relation.coach.first_name} --- #{relation.mentee.first_name} "] }, :include_blank => false
  #   end
  #   f.actions
  # end

  show do |user|
    span do
      link_to "Back to Events List", admin_events_path
    end
    attributes_table do
      row :title
      row :description
      row :starttime
      row :endtime
      row :profile
      # row :coach_mentee_relation_id
    end
    active_admin_comments
  end

end
