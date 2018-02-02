class Order < ApplicationRecord
    belongs_to :user
    has_one :employee_order, dependent: :destroy
    has_many :attachments, dependent: :destroy
    belongs_to :template
    enum status: [:pending, :assigned, :complete, :accepted, :in_revision]
end
