class User < ApplicationRecord
  has_many :login_credentials
  has_one :role
end
