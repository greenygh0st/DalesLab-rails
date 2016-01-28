class User < ActiveRecord::Base
  #interesting things to note here...https://www.railstutorial.org/book/updating_and_deleting_users
  has_secure_password

  has_many :blogs
  has_many :portfolios

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
