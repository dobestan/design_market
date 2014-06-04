class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_activation_token

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def create_activation_token
      self.activation_token = User.encrypt(User.new_remember_token)
    end

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
