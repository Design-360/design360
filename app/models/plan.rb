class Plan < ApplicationRecord
    serialize :stripe_response, JSON
end
