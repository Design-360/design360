class MessagesController < ApplicationController
    
    def create
        @message = Message.new(message_params)
        @message.save!
        #     redirect_to @message.chat, notice: "Your message has been successfully sent"
        # else
        #     redirect_to @message.chat, alert: "Something went wrong please try again"
        # end
    end
    
    private
    
    def message_params
        params.require(:message).permit(:document,:content,:message_sender_type,:message_sender_id,:chat_id)
    end
end
