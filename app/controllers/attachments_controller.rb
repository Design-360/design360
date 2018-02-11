class AttachmentsController < ApplicationController
    before_action :authenticate_employee!
    
    def new
        @order = Order.find(params[:format])
        @attachment = @order.attachments.new
    end
    
    def create
        @order = Order.find(params[:order_id])
        @attachment = @order.attachments.new(attachment_params)
        @attachment.employee_id = current_employee.id
        if params[:avatar_type] == "complete"
            @attachment.avatar_type = "complete"
            @order.update(:status => "complete")
        end
        if @attachment.save
            redirect_to order_path(@order), notice: "Order Marked Complete!"
        else
            redirect_to managers_dashboard_path, alert: "Order could not be completed"
        end
    end
    
    private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
        params.require(:attachment).permit(:avatar, :avatar_type)
    end
end