class OrdersController < ApplicationController
    before_action :set_order, only: [:show,:edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create]
    authorize_resource
    
    def new
        @order = current_user.orders.new
        @attachment = @order.attachments.new
    end
    
    def create
        @order = current_user.orders.new(order_params)
        if @order.save
            redirect_to clients_dashboard_path, notice: 'Order was successfully created.'
        else
            redirect_to dashboard_path, notice: 'error'
        end
    end
    
    def show
        @attachment = @order.attachments.new
    end
    def edit
        @templates = Template.all
    end
    
    def update
        if @order.update(order_params)
            if params[:status] == "accepted"
                @order.update(:status => "accepted")
            end
            redirect_to clients_dashboard_path, notice: 'Order was successfully updated.'
        else
            redirect_to clients_dashboard_path, notice: 'error.'
        end
    end
    
    def destroy
        @order.destroy
        redirect_to clients_dashboard_path, notice: 'Order was successfully destroyed.'
    end
    
    private
    
    def set_order
        @order = Order.find(params[:id])
    end
    
    def load_client
        @client = current_user
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
        params.require(:order).permit(:amount, :rating, :review,:duration, :design_type, :size_format,:color,:content,:description, :status, attachments_attributes: [:id, :order_id, :employee_id, :avatar_type, :avatar, :_destroy])
    end
end