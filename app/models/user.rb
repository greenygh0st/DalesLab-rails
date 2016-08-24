class User < ActiveRecord::Base
  #interesting things to note here...https://www.railstutorial.org/book/updating_and_deleting_users
  #before_save :lock_account

  has_secure_password

  has_many :blogs
  has_many :portfolios

  def two_factor_valid code
    return true if code == ROTP::TOTP.new(self.auth_secret).now.to_s
  end

  def assign_auth_secret
    self.auth_secret = ROTP::Base32.random_base32
  end

  def member?
    self.role == 'member'
  end

  def editor?
    self.role == 'editor'
  end

  def admin?
    self.role == 'admin'
  end

  def increment_login_attempts
    self.login_attempts += 1
    self.save
  end

  private
  def lock_account
    self.locked = true if lockdown_threshold_exceeded
  end

  private
  def lockdown_threshold_exceeded?
    self.login_attempts >=5
  end
end
