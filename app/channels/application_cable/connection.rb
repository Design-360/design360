module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user

    # def connect
    #   self.current_user = find_verified_user
    # end

    # private
    #   def find_verified_user
    #     # p "---------------------"
    #     # p "hello"
    #     # p cookies.encrypted       
    #     # p User.find_by(id: cookies.signed['user.id'])
    #     # p "---------------------"
    #     verified_user = User.find_by(id: cookies.signed['user.id']) if cookies.signed['user.id']
    #     verified_user = Employee.find_by(id: cookies.signed['employee.id']) if cookies.signed['employee.id']
    #     if verified_user
    #       logger.add_tags verified_user.email
    #       verified_user
    #     else
    #       reject_unauthorized_connection
    #     end
    #   end
  end
end
