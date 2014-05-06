class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name, :address, :home_phone, :availablity_time, :best_time_to_call, :date_of_birth)
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name, :address, :home_phone, :availablity_time, :best_time_to_call, :date_of_birth, :remember_me)
  end
end