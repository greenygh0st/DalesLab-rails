class Blog < ActiveRecord::Base
  belongs_to :user
  validates :title, :presence => true
  validates :urllink, :presence => true
end
