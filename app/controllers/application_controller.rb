class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters_admin, if: :devise_controller?
  before_action :configure_permitted_parameters_user, if: :devise_controller?
  before_action :configure_permitted_parameters_admin_edit, if: :devise_controller?
  before_action :configure_permitted_parameters_user_edit, if: :devise_controller?
  before_action :set_search
  before_action :message_check, if: :user_signed_in?

  private
  def configure_permitted_parameters_admin
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def configure_permitted_parameters_admin_edit
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  def configure_permitted_parameters_user
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :grade_id, :subject_id, :course_id, :introduction])
  end

  def configure_permitted_parameters_user_edit
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :grade_id, :subject_id, :course_id, :introduction])
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      root_path
    when User
      root_path
    end
  end

  def set_search
    @p = Source.ransack(params[:q])
  end

  def message_check
    @yet_messages = 0
    current_user.entries.each do |room|
      @yet_messages += room.room.yet_messages(current_user)
    end
  end
end