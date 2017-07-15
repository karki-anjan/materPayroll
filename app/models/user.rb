class User < ApplicationRecord
  mount_uploader :profileimg, ProfileimgUploader

  validates :username, uniqueness: { case_sensitive: false }, 
  presence: true, length: { minimum: 5, maximum: 50 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
  validates :base_salary, presence: true


  has_many :reimbursements, dependent: :destroy
  has_many :allowances, dependent: :destroy
  has_many :dope_adjustments, dependent: :destroy
  has_many :nope_adjustments, dependent: :destroy

  has_many :payslips, inverse_of: :employee, foreign_key: :employee_id

  def self.search(search)
    where("name LIKE ?", "%#{search}%") 
  end

  # def total_reimbursement
  #   total_reimbursement = 0
  #   if self.reimbursements
  #     self.reimbursements.each do |reimbursement|
  #     end

  # end

# def self.search(search)
#   if search
#     find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
#   else
#     find(:all)
#   end
# end


end
