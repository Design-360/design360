class PlanSubscriber < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  serialize :stripe_response, JSON
  before_destroy :set_user_subscription_status
  
  def set_user_subscription_status
    self.user.not_subscribe!
  end
end
