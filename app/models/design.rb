class Design < ActiveRecord::Base
  belongs_to :user
  belongs_to :request
end
