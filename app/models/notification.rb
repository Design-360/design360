class Notification < ApplicationRecord
    enum status:[:created,:deleted,:updated,:modification,:completed,:delivered,:reviewed,:assign_order,:ready_for_review]
    belongs_to :notify, polymorphic: true
    belongs_to :recipient, polymorphic: true
    belongs_to :actor, polymorphic: true
    
    after_create_commit :notification_job
    
    def notification_job
        NotificationJob.perform_later(self)
        EmployeeMailer.notification_email(self).deliver_later
    end
end
