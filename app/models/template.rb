class Template < ApplicationRecord
    has_attached_file :image, :default_url => ':s3_domain_url', :path => '/:class/:attachment/:id_partition/:style/:filename', :s3_host_name => 's3.amazonaws.com'
    has_many :orders, dependent: :destroy
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
