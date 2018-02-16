class Attachment < ApplicationRecord
    belongs_to :order
    has_attached_file :avatar, :default_url => ':s3_domain_url', :path => '/:class/:attachment/:id_partition/:style/:filename', :s3_host_name => 's3.amazonaws.com'
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
    enum avatar_type: [:brand_asset, :inspiration, :complete]
end
