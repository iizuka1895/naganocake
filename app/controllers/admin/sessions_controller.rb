
class Admin::SessionsController < Devise::SessionsController
  
  def after_sign_in_path_for(resource)
    admin_orders_path
  end
  
  def after_sign_out_path_for(resource)
    new_admin_session_path
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

 
  def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end