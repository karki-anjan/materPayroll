class AddAttachmentAvatarToReimbursements < ActiveRecord::Migration
  def self.up
    change_table :reimbursements do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :reimbursements, :avatar
  end
end
