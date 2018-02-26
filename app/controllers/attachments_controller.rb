class AttachmentsController < ApplicationController
    
    def create
        @order = Order.find(params[:order_id])
        @attachment = @order.attachments.new(attachment_params)
        if current_employee
            @attachment.employee_id = current_employee.id
        end
        if @attachment.avatar_type == "complete"
            @order.update(:status => "delivered")
        end
        if @attachment.save
            redirect_to order_path(@order), notice: "Order Updated!"
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