class User < ApplicationRecord
  has_many :login_credentials
  has_and_belongs_to_many :roles
end
