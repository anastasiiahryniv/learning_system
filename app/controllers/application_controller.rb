class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_student, :current_instructor

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name surname])
  end

  private

  def user_not_authorized
    flash[:alert] = I18n.t 'not_authorized'
    redirect_to root_path
  end

  def pundit_user
    current_student || current_instructor
  end
end
