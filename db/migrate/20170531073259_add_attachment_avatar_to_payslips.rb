class AddAttachmentAvatarToPayslips < ActiveRecord::Migration
  def self.up
    change_table :payslips do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :payslips, :avatar
  end
end
