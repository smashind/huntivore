class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def javascript_variables(variables)
    @javascript_variables ||= {}
    @javascript_variables.merge!(variables)
  end

  def bad_slug?(object)
    params[:id] != object.to_param
  end

  def redirect_to_good_slug(object)
    redirect_to controller: controller_name, action: params[:action], id: object.to_param, status: 301
  end


  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :accepted_terms, :owner, :outfitter])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :facebook, :twitter, :website, :instagram, :owner, :outfitter, :unread_messages])
  end

  def after_sign_in_path_for(resource)
  	user_path(current_user)
	end
end
