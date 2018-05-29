class User < ApplicationRecord
  has_many :login_credentials
  has_and_belongs_to_many :roles
  has_many :permissions, through: :roles
  has_many :sent_shifts, class_name: 'Shift', foreign_key: 'sender_id'
  has_many :received_shifts, class_name: 'Shift', foreign_key: 'receiver_id'
  has_many :approved_shifts, class_name: 'Shift', foreign_key: 'approver_id'

  def show_name
    first = first_name
    last = last_name
    prefer = prefer_name

    if prefer
      first = prefer
    end

    if last
      last = last[0] + '.'
    end

    "#{first} #{last}"
  end

  def self.system_robot
    Role.where(title: 'Robot').first.users.first
  end
end
