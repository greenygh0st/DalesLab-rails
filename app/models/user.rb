class User < ActiveRecord::Base
  has_secure_password

  has_many :blogs

  def member?
    self.role == 'member'
  end

  def editor?
    self.role == 'editor'
  end

  def admin?
    self.role == 'admin'
  end
end
