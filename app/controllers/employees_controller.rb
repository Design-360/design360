class EmployeesController < ApplicationController
    before_action :set_manager, only: [ :edit, :update, :destroy]
    authorize_resource
    def new
        @manager = Employee.new
    end
    
    def listing
       @managers = Employee.where(:role => "manager")
    end
    
    def show
        @order = Order.find(params[:format])
        assign = EmployeeOrder.new(:employee_id => params[:id], :order_id => @order.id)
        if assign.save
            @order.update!(:status => "assigned", :template_id => @order.template_id)
            redirect_to admin_dashboard_path, notice: 'Order was successfully assigned'
        else
            redirect_to admin_dashboard_path, alert: 'error'
        end
    end
    
    def create
        @manager = Employee.new(manager_params)
        if @manager.save
            EmployeeMailer.welcome_email(@manager,params[:employee][:password]).deliver
            redirect_to admin_managers_path, notice: 'Manager was successfully created.'
        else
            redirect_to admin_managers_path, alert: "Error"
        end
    end
    
    def edit
    end
    
    def update
        @manager = Employee.update(manager_params)
        if current_employee.admin?
            return redirect_to admin_dashboard_path, notice: 'Profile was successfully updated.'
        elsif current_employee.manager?
            redirect_to managers_dashboard_path, notice: 'Profile was successfully updated.'
        end
    end
    
    def destroy
        @manager.destroy
        redirect_to admin_managers_path, notice: 'Manager was successfully destroyed.'
    end
    
    private
    
    def set_manager
        @manager = Employee.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def manager_params
        params.require(:employee).permit(:name, :email, :password, :password_confirmation)
    end
end
