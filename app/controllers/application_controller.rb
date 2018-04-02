class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user
  before_action :unread_message_count
  
  def unread_message_count
    if @signed_in_user
      @unread_message_count = @signed_in_user.chats.map{|c| c.messages.where.not(message_sender: @signed_in_user,read: true).count }.compact.sum
    end
    
  end
  
  
  def user
    @signed_in_user = current_user || current_employee
  end
  
  def after_sign_in_path_for(resource)
    if current_user
      current_user.subscribe? ? clients_dashboard_path: root_path
      # root_path
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
  

  
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render file: 'home/error', status: 404 
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end
  
  protected
    def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
