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

end
