class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :small => "200x200>" },
                    #:url  => "/assets/portfolio/:id/:style/:basename.:extension",
                    :path => "/daleslab/#{Rails.env}/portfolio/:id/:style/:basename.:extension"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
