class User < ApplicationRecord
  has_many :login_credentials
end
