class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    if user.is_a?(Employee)
      if user.admin?
        can :manage, :all
      else
        can :update, Employee, id: user.id
        can [:show,:update], Order do |ord|
          eorder = EmployeeOrder.where(:order_id => ord.id, :employee_id => user.id)
          eorder.present?
        end
        can [:create, :update], Attachment, employee_id: user.id
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
