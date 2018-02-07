class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    if user.is_a?(Employee)
      if user.admin?
        can :manage, :all
      else
        can :update, Order, EmployeeOrder do |ord|
          check = ord.where(:order_id => id, :employee_id => user.id)
          check.present?
        end
        can :manager_dashboard, :home
        can :index, :home
        can :error, :home
      end
    elsif user.is_a?(User)
        can :client_dashboard, :home
        can :index, :home
        can :manage, Order, user_id: user.id
        can :error, :home
    else
      can :index, :home
      can :error, :home
    end
  end
end
