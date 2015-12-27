class User < ActiveRecord::Base
  has_secure_password

  has_many :blogs

  def editor?
    self.role == 'editor'
  end

  def admin?
    self.role == 'admin'
  end
end
