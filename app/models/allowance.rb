class Allowance < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :description, presence: true, length: { maximum: 140 }
  validates :amount, presence: true
  default_scope -> { order(created_at: :desc) }
end
