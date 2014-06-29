class Request < ActiveRecord::Base
  before_create :create_token

  has_many :designs
  belongs_to :user

  private
    def create_token
      self.token = SecureRandom.urlsafe_base64.first(6)
    end
end
