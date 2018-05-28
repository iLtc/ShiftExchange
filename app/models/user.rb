class User < ApplicationRecord
  has_many :login_credentials
  has_and_belongs_to_many :roles
  has_many :permissions, through: :roles
  has_many :sent_shifts, class_name: 'Shift', foreign_key: 'sender_id'
  has_many :received_shifts, class_name: 'Shift', foreign_key: 'receiver_id'
  has_many :approved_shifts, class_name: 'Shift', foreign_key: 'approver_id'

  def show_name
    if prefer_name
      "#{prefer_name} #{last_name[0]}."
    else
      "#{first_name} #{last_name[0]}."
    end
  end
end
