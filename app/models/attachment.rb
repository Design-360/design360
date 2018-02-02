class Attachment < ApplicationRecord
    belongs_to :order
    has_attached_file :image
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    has_attached_file :pdf
    validates_attachment_content_type :pdf, content_type: ["application/pdf"]
end
