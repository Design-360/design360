class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    if current_user
      clients_dashboard_path
    elsif current_employee and current_employee.admin?
      admin_dashboard_path
    else
      managers_dashboard_path
    end
  end
  
  def current_auth_resource
    if user_signed_in?
      current_user
    elsif employee_signed_in?
      current_employee
    end
  end

  def current_ability
      @current_ability or @current_ability = Ability.new(current_auth_resource)
  end
  
  rescue_from ActionController::RoutingError do |exception|
    logger.error 'Routing error occurred'
    render plain: '404 Not found', status: 404 
  end
  
  rescue_from ActionView::MissingTemplate do |exception|
    Rails.logger.debug ger.error exception.message
    render plain: '404 Not found', status: 404 
  end
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    Rails.logger.debug ger.error exception.message
    render plain: '404 Not found', status: 404 
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
end
