class HomeController < ApplicationController
    before_action :authenticate_user!, only:[:client_dashboard]
    before_action :authenticate_employee!, only:[:manager_dashboard, :admin_dashboard]
    authorize_resource :class => false, except: [:privacy_policy,:terms,:unsub_user]
    
    def index
        @stripe_list = Stripe::Plan.all
        @plans = @stripe_list[:data]
    end
    
    def admin_orders
        @pending_orders = Order.where(:status => "pending")
        @assigned_orders = Order.where(:status => "assigned")
        @delivered_orders = Order.where(:status => "delivered")
        @complete_orders = Order.where(:status => "complete")
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
    
    def admin_dashboard
        @pending_orders = Order.where(:status => "pending")
        # @delivered_orders = []
    end
    
    def manager_dashboard
        @orders = current_employee.orders
        @pending_orders = @orders.assigned + @orders.in_revision
        @delivered_orders = @orders.delivered
        @complete_orders = @orders.complete
    end
    def notifications
        user = current_employee || current_user
        @notifications = user.notifications.order('created_at DESC')
    end
    
    def client_dashboard
        if @signed_in_user.subscribe?
            @orders = current_user.orders
            @pending_orders = current_user.orders.pending + current_user.orders.in_revision
            @assigned_orders = current_user.orders.assigned
            @delivered_orders = current_user.orders.delivered
            @complete_orders = current_user.orders.complete
        else
            @stripe_list = Stripe::Plan.all
            @plans = @stripe_list[:data]
            render 'unsub_user'
        end
    end
    
    def unsub_user
    end
    
    def 
    
    def error
    end
    def privacy_policy
    end
    def terms
    end
    
end
