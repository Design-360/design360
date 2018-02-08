class OrdersController < ApplicationController
    before_action :set_order, only: [:show,:edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create]
    load_and_authorize_resource
    
    def new
        @order = current_user.orders.new
        @templates = Template.all
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
        
    end
    def edit
    end
    
    def update
        if @order.update(order_params)
            redirect_to dashboard_path, notice: 'Order was successfully updated.'
        else
            redirect_to dashboard_path, notice: 'error.'
        end
    end
    
    def destroy
        @order.destroy
        redirect_to dashboard_path, notice: 'Order was successfully destroyed.'
    end
    
    private
    
    def set_order
        # begin
            @order = Order.find(params[:id])
        # rescue ActiveRecord::RecordNotFound
            # Rails.logger.debugger.error exception.messagec
            # render plain: '404 Not found', status: 404 
        # end
    end
    
    def load_client
        @client = current_user
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
        params.require(:order).permit(:amount, :duration, :template_id, :status)
    end
end