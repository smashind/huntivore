class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # redirect to create property path after signing up from /listing page
  def after_sign_up_path_for(resource)
  	if params[:list]
  		'/properties/new'
  	end
  end
end