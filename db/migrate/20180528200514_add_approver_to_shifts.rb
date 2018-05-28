class AddApproverToShifts < ActiveRecord::Migration[5.1]
  def change
    add_reference :shifts, :approver, foreign_key: true
  end
end
