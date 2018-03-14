class ChatsController < ApplicationController
    load_and_authorize_resource :only => [:show]
    def index
        user_ = current_employee || current_user
        chatted_subscribers = user_.chatted_users
        # @chatted_users = chatted_subscribers.uniq.select{|p| p.subscriber!= user}
        # byebug
        if employee_signed_in?
            # byebug
            if user_.admin?
                @chatable_users = Employee.where(role:1) + current_employee.chats.map(&:chat_users).reject(&:blank?).flatten
            elsif user_.manager?
                @chatable_users = Employee.where(role:0) + current_employee.order_users
            end
        elsif user_signed_in?
            
            @chatable_users = Employee.where(role:0) + current_user.order_managers
            # byebug
        end
    end
    
    def show
        @chat = Chat.find(params[:id])
        
        @message = Message.new
        @chat_messages  = @chat.messages
        # authorize! :show, @chat
    end
    
    def create
        
        user = current_employee || current_user
        if params[:chat_with].present?
            other_user = Employee.find(params[:chat_with][:id]) if params[:chat_with][:type]=='Employee'
            other_user = User.find(params[:chat_with][:id]) if params[:chat_with][:type]=='User'
            chat = user.chatted_with?(other_user)
            logger.info "-------------"
            logger.info chat
            logger.info "-------------"
            
            if chat[0]
                redirect_to chat[1]
            else
                @chat = Chat.new
                @chat.subscriptions.build(subscriber_type: user.class.to_s, subscriber_id: user.id)
                if params[:chat_with].present? and params[:chat_with][:type] == 'User'
                    @chat.subscriptions.build(subscriber: User.find(params[:chat_with][:id])) if params[:chat_with].present?
                elsif params[:chat_with].present? and params[:chat_with][:type] == 'Employee'
                    @chat.subscriptions.build(subscriber: Employee.find(params[:chat_with][:id])) if params[:chat_with].present?
                end
                if @chat.save!
                    redirect_to @chat, notice: 'chat created'
                else
                    redirect_to chats_path
                end
            end
        end
        
    end
end
