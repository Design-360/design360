class Attachment < ApplicationRecord
    belongs_to :order
    has_attached_file :avatar
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
    enum avatar_type: [:brand_asset, :inspiration, :complete]
end
