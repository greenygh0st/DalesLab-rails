class Subscription < ActiveRecord::Base
  validates :email, :presence => true
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
