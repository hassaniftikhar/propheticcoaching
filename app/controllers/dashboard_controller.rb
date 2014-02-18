class DashboardController < ApplicationController
  # before_action :set_calendar_properties
  # before_action :set_mentee_id  
  def index
  		@latest_resources = Ebook.order("created_at desc").limit(5)
  end

    def set_mentee_id
      params[:mentee_id] = params[:id]
    end

    def set_calendar_properties
      gon.editable = current_user.is_admin? ? true : false
      @calendar_editable = gon.editable
    end
end
