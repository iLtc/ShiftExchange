class User < ApplicationRecord
  has_many :login_credentials
  has_and_belongs_to_many :roles
  has_many :permissions, through: :roles
  has_and_belongs_to_many :shifts

  def show_name
    if prefer_name
      "#{prefer_name} #{last_name[0]}."
    else
      "#{first_name} #{last_name[0]}."
    end
  end
end
