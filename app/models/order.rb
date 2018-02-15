class Order < ApplicationRecord
    belongs_to :user
    has_one :employee_order, dependent: :destroy
    has_one :employee, through: :employee_order
    has_many :attachments, dependent: :destroy
    enum status: [:pending, :assigned, :delivered, :complete, :in_revision]
    enum rating: [:one_star, :two_star, :three_star, :four_star, :five_star]
    accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true
end
