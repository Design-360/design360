class Subscription < ApplicationRecord
    belongs_to :chat
    belongs_to :subscriber, :polymorphic => true
end
