class RegistrationsController < Devise::RegistrationsController
	layout "simple_form"

  def edit
    render :layout => "dashboard"
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if update_resource(resource, account_update_params)
      yield resource if block_given?
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      render "edit"
    end
  end
  
  protected
    def after_update_path_for(resource)
      account_path(resource.username)
    end

    def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end