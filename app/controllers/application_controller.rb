class ApplicationController < ActionController::Base
  add_flash_types :success, :warning, :danger, :info
  before_action :authorized
  protect_from_forgery with: :exception
  helper_method :respond_modal_with
  
  before_action :configure_permitted_parameters, if: :devise_controller?
   rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_url, :warning => exception.message }
    end
  end
    
    protected

    def authorized
      if user_signed_in?
        true
      else
        false
      end

      #redirect_to '/my/users/sign_in' unless user_signed_in?
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :admin, :coach, :parent, :player) }
    end

    def after_sign_in_path_for(resource)
      current_user		      # return the path based on resource
    end

    def after_sign_out_path_for(resource)
      '/my/users/sign_in' 
    # return the path based on resource
    end

  def respond_modal_with(*args, &blk)
  	
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

end
