class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :sign_up_permitted_parameters, :only => [:create]
	before_filter :account_update_permitted_parameters, :only => [:update]

  protected
    def after_sign_up_path_for(resource)
	    root_path
    end

    def sign_up_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :username << :email << :login
    end

    def account_update_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << :username << :email << :login
    end
end