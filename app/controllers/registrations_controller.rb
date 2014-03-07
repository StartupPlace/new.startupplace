class RegistrationsController < Devise::RegistrationsController
	layout "dashboard"

	def update
    super
  end
  
  protected
    def after_update_path_for(resource)
      account_path(resource)
    end

    def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end