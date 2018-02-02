class AttachmentsController < ApplicationController
    
    before_action :load_order, only: [:new, :create]
    
    def new
        @attachment = @order.attachments.new
    end
    
    def create
        @attachment = @order.attachments.new(attachment_params)
        if @attachment.save
            @order.update(:status => "complete", :template_id => @order.template_id)
            redirect_to dashboard_path, notice: 'Files successfully attached.'
        else
            redirect_to dashboard_path, alert: 'error'
        end
    end
    
    private
    
    def load_order
        @order = Order.find(params[:order_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
        params.require(:attachment).permit(:image, :pdf)
    end
end