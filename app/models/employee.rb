class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_destroy :reset_order
  has_many :employee_orders, dependent: :destroy
  has_many :orders, through: :employee_orders
  enum role: [ :admin, :manager]
  
  def reset_order
    employee_orders = EmployeeOrder.where(:employee_id => self.id)
      
    employee_orders.each do |eorder|
      order = Order.find(eorder.order_id)
      if order.status == "assigned" or order.status == "in_revision"
        order.update(:status => "pending")
      end
    end
  end
end
