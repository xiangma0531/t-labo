class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :authenticate_user!
  before_action :configure_permitted_parameters_admin, if: :devise_controller?
  before_action :configure_permitted_parameters_user, if: :devise_controller?
  before_action :configure_permitted_parameters_admin_edit, if: :devise_controller?
  before_action :configure_permitted_parameters_user_edit, if: :devise_controller?

  private
  def configure_permitted_parameters_admin
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_permitted_parameters_admin_edit
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  def configure_permitted_parameters_user
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :grade_id, :subject_id, :course_id, :introduction])
  end

  def configure_permitted_parameters_user_edit
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :grade_id, :subject_id, :course_id, :introduction])
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      root_path
    when User
      root_path
    end
  end
end