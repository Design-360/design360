class Plan < ApplicationRecord
    serialize :stripe_response, JSON
    has_many :plan_subscribers,dependent: :destroy
    
end
