class Order < ApplicationRecord
    belongs_to :user
    has_one :employee_order, dependent: :destroy
    has_one :employee, through: :employee_order
    has_many :attachments, dependent: :destroy
    enum status: [:pending, :assigned, :delivered, :complete, :in_revision]
    enum rating: [:one_star, :two_star, :three_star, :four_star, :five_star]
    accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
    
    has_many :notifications, as: :notify, dependent: :destroy
    
    after_create_commit :create_notification
    after_update :status_notify, :if => proc{ |obj| obj.status_changed? && obj.status == 'delivered' }
    after_update :notify_accepted, :if => proc{ |obj| obj.status_changed? && obj.status == 'complete' }
    after_update :notify_in_revision, :if => proc{ |obj| obj.status_changed? && obj.status == 'in_revision' }
    
    def notify_in_revision
        all_admins = Employee.where(role:0)
        all_admins.each do |admin|
            Notification.create!(notify: self, recipient: admin,actor: self.user, status: "modification")
        end
        Notification.create!(notify: self, recipient: self.employee,actor: self.user, status: "modification")
    end
    
    def notify_accepted
        all_admins = Employee.where(role:0)
        all_admins.each do |admin|
            Notification.create!(notify: self, recipient: admin,actor: self.user, status: "completed")
        end
        Notification.create!(notify: self, recipient: self.employee,actor: self.user, status: "completed")
    end
    
    def status_notify
        all_admins = Employee.where(role:0)
        all_admins.each do |admin|
            Notification.create!(notify: self, recipient: admin,actor: self.employee, status: "delivered")
        end
        Notification.create!(notify: self, recipient: self.user,actor: self.employee, status: "ready_for_review")
    end
    
    
    
    def create_notification
        all_admins = Employee.where(role:0)
        all_admins.each do |admin|
            logger.info self
            notification = Notification.create!(notify: self,recipient: admin,actor: self.user,status:0)
            # NotificationJob.perform_later(notification)
        end
    end
end
