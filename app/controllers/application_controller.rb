class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to coach_path(current_user), :alert => exception.message
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless (current_user && current_user.has_role?(:admin))
  end

  def current_permission
    @current_permission ||= ::Permissions.permission_for(current_user)
  end

  private

  def after_sign_in_path_for(resource)
    PrivatePub.publish_to("/chats/talk", :message => {message: "#{current_user.name} entered.", user_name: ""}.to_json)
    current_user.is_admin? ? root_path : coach_path(current_user.id)
  end

  def after_sign_out_path_for(resource_or_scope)
    PrivatePub.publish_to("/chats/talk", :message => {message: "#{current_user.name} left.", user_name: ""}.to_json)
    new_user_session_path
  end

end
