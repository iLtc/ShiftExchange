class AddSenderAndReceiverToShifts < ActiveRecord::Migration[5.1]
  def change
    add_reference :shifts, :sender, foreign_key: true
    add_reference :shifts, :receiver, foreign_key: true
  end
end
