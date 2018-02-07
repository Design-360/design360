class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :orders, through: :employee_order
  has_one :employee_order, dependent: :destroy
  enum role: [ :admin, :manager]
  
end
