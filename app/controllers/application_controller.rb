class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
    def user_activo!
      if user_signed_in? && current_user.bloqueado?
        redirect_to root_path 
        flash.alert = "Estas bloqueado"
      end
    end

    def authenticate_normal_user!
      redirect_to root_path unless user_signed_in? && current_user.is_normal_user?
    end

    def authenticate_admin!
  	  redirect_to root_path unless user_signed_in? && current_user.is_admin?
    end

    def authenticate_gold_user!
      redirect_to root_path unless user_signed_in? && current_user.is_gold_user?
    end

    def validar_post_diarios
      if user_signed_in?
        #current_user.reset_post_diarios
        if current_user.is_normal_user?
          if not current_user.post_diarios < 1
           redirect_to root_path
           flash.alert = "Ya has alcanzado el limite de post diarios"
          end
        end
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name_user, :name, :last_name, :fecha_nacimiento, :email, :password, :password_confirmation, :current_password, :foto_perfil) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name_user, :name, :last_name, :fecha_nacimiento, :email, :password, :password_confirmation, :foto_perfil) }
    end
end
