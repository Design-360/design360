class Template < ApplicationRecord
    has_attached_file :image
    has_many :orders, dependent: :destroy
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
