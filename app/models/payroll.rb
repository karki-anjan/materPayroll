class Payroll < ApplicationRecord
  # validates :period, presence: true
  validates :start_period, presence: true
  validates :end_period, presence: true
  validate :end_is_after_start_period

  has_many :payslips, inverse_of: :payroll, dependent: :destroy
  after_create :create_payslips
  before_save :update_id


  def self.search(search)
    # self.payslips.map(&:payslips).joins(:user).where("name LIKE ?", "%#{search}%")
    # left_joins(:payslips, :users).where("name LIKE ?", "%#{search}%")
    left_joins(:payslips, :users).where("user.name LIKE ?", "%#{search}%")
  end

private
  def create_payslips
    User.all.each do |employee|
      self.payslips.find_by(employee: employee) || self.payslips.create(employee: employee)
    end
  end

  def end_is_after_start_period
    errors.add(:end_period, "should be after start period") if end_period <= start_period
  end

  def update_id
    largest_id = Payroll.count + 1
    while Payroll.find_by(id: largest_id)
      largest_id += 1
    end
    self.id = largest_id
  end
end
