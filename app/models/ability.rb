class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    if user.is_a?(Employee)
      if user.admin?
        can :manage, :all
        can :notifications, :home
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
        can :show, Chat do |chat|
          subscribers = chat.subscriptions.pluck(:subscriber_type,:subscriber_id)
          subscribers.include?([user.class.to_s, user.id])
        end
        can :notifications, :home
      end
    elsif user.is_a?(User)
        can :client_dashboard, :home
        # if user.subscribe?
        can :index, :home
        can [:read,:update,:destroy], Order,user_id: user.id
        can :create, Order if user.plan and user.orders and user.orders.where.not(status:"complete").count < user.plan.order_count
        can :error, :home
        
        can :show, Chat do |chat|
          subscribers = chat.subscriptions.pluck(:subscriber_type,:subscriber_id)
          subscribers.include?([user.class.to_s, user.id])
        end
        can :notifications, :home
        
    else
      can :index, :home
      can :error, :home
    end
  end
end
