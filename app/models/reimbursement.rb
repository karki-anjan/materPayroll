class Reimbursement < ApplicationRecord
  belongs_to :user
  # has_one :payslip

  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  validates :amount, presence: true
  default_scope -> { order(created_at: :desc) }
  has_attached_file :avatar, styles: { medium: "600x600>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/ 	

  def can_validate
    true
  end
end

