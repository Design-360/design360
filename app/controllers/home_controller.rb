class HomeController < ApplicationController
    
    def index
        
    end
    
    def admin_orders
        @pending_orders = Order.where(:status => "pending")
        @completed_orders = Order.where(:status => "complete")
        @employee_orders = EmployeeOrder.all
    end
    
    def admin_managers
        @managers = Employee.where(:role => "manager")
    end
    
    def admin_templates
        @templates = Template.all
    end
    
    def admin_clients
        @clients = User.all
    end
    
    
    def dashboard
        if current_employee and current_employee.role == "manager"
            @employee_orders = EmployeeOrder.where(:employee_id => current_employee.id)
            @order_ids = @employee_orders.pluck(:order_id).uniq
            @orders = []
            @order_ids.each do  |a|
                @o = Order.find(a)
                if @o.status == "assigned" or @o.status == "in_revision"
                    @orders << @o
                end
            end
        end
        if current_user
            @orders = Order.where(:user_id => current_user.id)
            @pending_orders = []
            @complete_orders = []
            @accepted_orders = []
            @orders.each do |ord|
                if ord.status == "pending" or ord.status == "assigned"
                    @pending_orders << ord
                elsif ord.status == "accepted"
                    @accepted_orders << ord
                else
                    @complete_orders << ord
                end
                    
            end
        end
        @templates = Template.all
    end
end
