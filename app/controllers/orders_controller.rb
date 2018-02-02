class OrdersController < ApplicationController
    before_action :set_order, only: [ :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create]
    
    def new
        @order = current_user.orders.new
        @templates = Template.all
    end
    
    def create
        @order = current_user.orders.new(order_params)
        if @order.save
            redirect_to dashboard_path, notice: 'Order was successfully created.'
        else
            redirect_to dashboard_path, notice: 'error'
        end
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
        @order = Order.find(params[:id])
    end
    
    def load_client
        @client = current_user
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
        params.require(:order).permit(:amount, :duration, :template_id, :status)
    end
end